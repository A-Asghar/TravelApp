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

  getTravelerBookings() async {
    setState(() => isLoading = true);
    BookingNetwork bookingNetwork = BookingNetwork();
    var snapshot = await bookingNetwork.getTravelerHotelBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    bookingsFromFirebase = snapshot.docs.map((doc) => doc.data()).toList();
    print(bookingsFromFirebase);
    if (mounted) {
      setState(() => isLoading = false);
    }
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
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : bookingsFromFirebase.isEmpty
            ? Center(child: poppinsText(text: "No Bookings Yet!"))
            : Expanded(
                child: ListView.builder(
                  itemCount: bookingsFromFirebase.length,
                  padding: const EdgeInsets.only(bottom: 60),
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: HotelCard(
                        bookingData: bookingsFromFirebase[index],
                      ),
                    );
                  },
                ),
              );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const HotelCard({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(bookingData['imageUrl']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: poppinsText(
                              text: bookingData['hotelName'],
                              size: 18.0,
                              fontBold: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 15),
                          poppinsText(
                            text: bookingData['hotelLocation'],
                            size: 14.0,
                            color: const Color(0xff616161),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              poppinsText(
                text: "Booked On : ${bookingData['bookingDate']}",
                size: 18.0,
                fontBold: FontWeight.w500,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
