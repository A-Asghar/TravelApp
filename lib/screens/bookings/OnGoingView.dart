import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../models/Detail.dart';
import '../../network/BookingNetwork.dart';
import '../../network/HotelNetwork.dart';
import '../../widgets/poppinsText.dart';

class OnGoingView extends StatefulWidget {
  const OnGoingView({Key? key}) : super(key: key);

  @override
  State<OnGoingView> createState() => _OnGoingViewState();
}

class _OnGoingViewState extends State<OnGoingView> {
  void initState() {
    super.initState();
    getTravelerBookings();
  }

  bool isLoading = false;
  List bookingsFromFirebase = [];
  List<Map<String, dynamic>> bookingsWithHotelDetail = [];

  getTravelerBookings() async {

    setState(() => isLoading = true);
    BookingNetwork bookingNetwork = BookingNetwork();
    var snapshot = await bookingNetwork.getTravelerHotelBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    bookingsFromFirebase = snapshot.docs.map((doc) => doc.data()).toList();
    await Future.forEach(bookingsFromFirebase, (booking) async {
      var detail = await getHotelNameUsingBookingId(booking['hotelId']);
      bookingsWithHotelDetail
          .add({'bookingDate': booking['bookingDate'], 'detail': detail});

    });
    // bookingsWithHotelDetail.forEach((element) {
    //   print(element['detail'].data.propertyInfo.summary.name);
    // });
    setState(() => isLoading = false);
  }

  getHotelNameUsingBookingId(propertyId) async {
    HotelNetwork hotelNetwork = HotelNetwork();
    var response = await hotelNetwork.detail(propertyId: propertyId);

    response = jsonDecode(response);

    Detail detail = Detail.fromJson(response);
    return detail;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(),)
        : bookingsWithHotelDetail.isEmpty ? Center(
        child: poppinsText(text: "No Bookings Yet!")) : Expanded(
      child: ListView.builder(
        itemCount: bookingsWithHotelDetail.length,
        padding: const EdgeInsets.only(bottom: 60),
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Constants.secondaryColor.withOpacity(0.05) ,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff04060F).withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                  bookingsWithHotelDetail[index]['detail'].data.propertyInfo.propertyGallery.images[0].image.url
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            poppinsText(
                              text: bookingsWithHotelDetail[index]['detail'].data.propertyInfo.summary.name ?? "",
                              size: 18.0,
                              fontBold: FontWeight.w700,
                            ),
                            const SizedBox(height: 15),
                            poppinsText(
                              text: bookingsWithHotelDetail[index]['detail'].data.propertyInfo.summary.location.address.city + ", " + bookingsWithHotelDetail[index]['detail'].data.propertyInfo.summary.location.address.countryCode,
                              size: 14.0,
                              color: const Color(0xff616161),
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Color(0xffEEEEEE)),
                    poppinsText(text: "Booked On : ${bookingsWithHotelDetail[index]['bookingDate']}",size: 22.0, fontBold: FontWeight.w500)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
