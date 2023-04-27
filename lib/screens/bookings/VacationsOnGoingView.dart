import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../network/BookingNetwork.dart';
import '../../widgets/poppinsText.dart';


class VacationsOnGoingView extends StatefulWidget {
  const VacationsOnGoingView({Key? key}) : super(key: key);

  @override
  State<VacationsOnGoingView> createState() => _VacationsOnGoingViewState();
}

class _VacationsOnGoingViewState extends State<VacationsOnGoingView> {
  void initState() {
    super.initState();
    getTravelerBookings();
  }

  bool isLoading = false;
  List bookingsFromFirebase = [];

  getTravelerBookings() async {
    setState(() => isLoading = true);
    BookingNetwork bookingNetwork = BookingNetwork();
    var snapshot = await bookingNetwork.getTravelerPackageBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    bookingsFromFirebase = snapshot.docs.map((doc) => doc.data()).toList();
    print(bookingsFromFirebase);
    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(),)
        : bookingsFromFirebase.isEmpty ? Center(
        child: poppinsText(text: "No Bookings Yet!")) :  Expanded(
      child: ListView.builder(
        itemCount: bookingsFromFirebase.length,
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
                            image: DecorationImage(
                              image: NetworkImage(
                                  bookingsFromFirebase[index]['imageUrl']
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
                              text: bookingsFromFirebase[index]['packageName'],
                              size: 18.0,
                              fontBold: FontWeight.w700,
                            ),
                            const SizedBox(height: 15),
                            poppinsText(
                              text: bookingsFromFirebase[index]['destination'],
                              size: 14.0,
                              color: const Color(0xff616161),
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      ],
                    ),
                    const Divider(color: Color(0xffEEEEEE)),
                    Row(
                      children: [
                        poppinsText(text: " Booked On : ${bookingsFromFirebase[index]['bookingDate']}",size: 22.0, fontBold: FontWeight.w500)
                      ],
                    )
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
