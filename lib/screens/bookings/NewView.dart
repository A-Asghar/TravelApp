import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/FlightBooking.dart';
import 'package:fyp/models/HotelBooking.dart';
import 'package:fyp/models/PackageBooking.dart';
import 'package:fyp/screens/ViewBooking.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../network/BookingNetwork.dart';
import '../../widgets/poppinsText.dart';

class NewView extends StatefulWidget {
  const NewView({Key? key}) : super(key: key);

  @override
  State<NewView> createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {
  @override
  initState() {
    super.initState();
    getTravelerBookings();
  }

  bool isLoading = false;
  List<dynamic> hotelBookings = [];
  List<dynamic> flightBookings = [];
  List<dynamic> vacationBookings = [];
  List<String> dates = [];

  getTravelerBookings() async {
    setState(() => isLoading = true);
    BookingNetwork bookingNetwork = BookingNetwork();
    var hotelSnapshot = await bookingNetwork.getTravelerHotelBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    var flightSnapshot = await bookingNetwork.getTravelerFlightBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);
    var vacationSnapshot = await bookingNetwork.getTravelerPackageBooking(
        travelerId: FirebaseAuth.instance.currentUser?.uid);

    hotelBookings = hotelSnapshot.docs.map((doc) => doc.data()).toList();
    flightBookings = flightSnapshot.docs.map((doc) => doc.data()).toList();
    vacationBookings = vacationSnapshot.docs.map((doc) => doc.data()).toList();

    hotelBookings.forEach((e) {
      if (!dates.contains(e['hotelCheckInDate'])) {
        dates.add(e['hotelCheckInDate']);
      }
    });

    flightBookings.forEach((e) {
      if (!dates.contains(e['flightDepartureDate'])) {
        dates.add(e['flightDepartureDate']);
      }
      if (e['returnFlightExists']) {
        if (!dates.contains(e['flightReturnDate'])) {
          dates.add(e['flightReturnDate']);
        }
      }
    });

    vacationBookings.forEach((e) {
      if (!dates.contains(e['vacationStartDate'])) {
        dates.add(e['vacationStartDate']);
      }
    });
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  int _currentStep = 0;

  @override
Widget build(BuildContext context) {
  return isLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : (hotelBookings.isEmpty &&
              flightBookings.isEmpty &&
              vacationBookings.isEmpty)
          ? Center(child: poppinsText(text: "No Bookings Yet!"))
          : ListView.builder(
              itemCount: dates.length,
              padding: const EdgeInsets.only(bottom: 60),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                List<Widget> bookingCards = [];

                var flightsOnDate = flightBookings.where((booking) =>
                    booking['flightDepartureDate'] == dates[index]);
                var flightsOnReturnDate = flightBookings.where((booking) =>
                    booking['flightReturnDate'] == dates[index]);
                var hotelsOnDate = hotelBookings.where((booking) =>
                    booking['hotelCheckInDate'] == dates[index]);
                var vacationsOnDate = vacationBookings.where((booking) =>
                    booking['vacationStartDate'] == dates[index]);

                flightsOnDate.forEach((booking) {
                  bookingCards.add(FlightCard(bookingData: booking));
                });

                flightsOnReturnDate.forEach((booking) {
                  bookingCards.add(FlightReturnCard(bookingData: booking));
                });

                hotelsOnDate.forEach((booking) {
                  bookingCards.add(HotelCard(bookingData: booking));
                });

                vacationsOnDate.forEach((booking) {
                  bookingCards.add(VacationCard(bookingData: booking));
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomStepper(
                      date: dates[index],
                      widget: Column(
                        children: bookingCards,
                      ),
                    )
                  ],
                );
              },
            );
}


  List<Step> _buildSteps() {
    List<Step> steps = [];
    for (int i = 0; i < dates.length; i++) {
      steps.add(
        Step(
          title: poppinsText(
            text: " Date: ${dates[i]}",
            fontBold: FontWeight.w500,
            size: 18.0,
          ),
          isActive: i == _currentStep,
          state: _getStepState(i),
          content: _buildStepContent(i),
        ),
      );
    }
    return steps;
  }

  StepState _getStepState(int i) {
    if (i == _currentStep) {
      return StepState.editing;
    } else if (i < _currentStep) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  Widget _buildStepContent(int index) {
    List<Widget> bookingCards = [];

    var flightsOnDate = flightBookings
        .where((booking) => booking['flightDepartureDate'] == dates[index]);
    var hotelsOnDate = hotelBookings
        .where((booking) => booking['hotelCheckInDate'] == dates[index]);
    var vacationsOnDate = vacationBookings
        .where((booking) => booking['vacationStartDate'] == dates[index]);

    flightsOnDate.forEach((booking) {
      bookingCards.add(FlightCard(bookingData: booking));
    });

    hotelsOnDate.forEach((booking) {
      bookingCards.add(HotelCard(bookingData: booking));
    });

    vacationsOnDate.forEach((booking) {
      bookingCards.add(VacationCard(bookingData: booking));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bookingCards,
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const HotelCard({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HotelBooking hotelBooking = HotelBooking.fromJson(bookingData);
        Get.to(() => ViewBooking(
              hotelBooking: hotelBooking,
            ));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
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
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.49,
                    child: poppinsText(
                      text: bookingData['hotelName'],
                      size: 14.0,
                      fontBold: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  poppinsText(
                    text: bookingData['hotelLocation'],
                    size: 12.0,
                    color: const Color(0xff616161),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.bottomRight,
                    width: MediaQuery.of(context).size.width * 0.49,
                    child: poppinsText(
                        text: "Checkout: ${bookingData['hotelCheckOutDate']}",
                        size: 12.0,
                        color: Constants.primaryColor,
                        fontBold: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Map<String, dynamic> bookingData;
  const FlightCard({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FlightBooking flightBooking = FlightBooking.fromJson(bookingData);
        Get.to(() => ViewBooking(
              flightBooking: flightBooking,
            ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: poppinsText(
                      text: 'Flight Duration',
                      size: 12.0,
                      fontBold: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: poppinsText(
                        text: bookingData['flightDuration'],
                        color: Constants.secondaryColor,
                        size: 12.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  poppinsText(
                    text: bookingData['fromTime'],
                    size: 15.0,
                    fontBold: FontWeight.w400,
                  ),
                  const Expanded(
                    child: Divider(
                      color: Constants.secondaryColor,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                  Transform.rotate(
                    angle: 90 * 3.1415 / 180,
                    child: const Icon(
                      Icons.flight,
                      color: Constants.primaryColor,
                      size: 25,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Constants.secondaryColor,
                      indent: 10,
                      endIndent: 20,
                    ),
                  ),
                  poppinsText(
                    text: bookingData['toTime'],
                    size: 15.0,
                    fontBold: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  poppinsText(
                    text: bookingData['fromCity'],
                    color: Constants.secondaryColor,
                  ),
                  poppinsText(
                    text: bookingData['toCity'],
                    color: Constants.secondaryColor,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.event_seat,
                        color: Constants.secondaryColor,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      poppinsText(
                        text: bookingData['cabin'],
                        color: Constants.secondaryColor,
                        size: 12.0,
                        fontBold: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 10),
                  poppinsText(
                    text: "\$" + bookingData['price'],
                    color: Constants.secondaryColor,
                    fontBold: FontWeight.w600,
                    size: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightReturnCard extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const FlightReturnCard({required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FlightBooking flightBooking = FlightBooking.fromJson(bookingData);
        Get.to(() => ViewBooking(
              flightBooking: flightBooking,
            ));
      },
      child: bookingData['returnFlightExists'] ? Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10, top: 5),
              child: poppinsText(
                text: '*Return Flight',
                size: 12.0,
                fontBold: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: poppinsText(
                      text: 'Flight Duration',
                      size: 12.0,
                      fontBold: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: poppinsText(
                        text: bookingData['returnFlightDuration'],
                        color: Constants.secondaryColor,
                        size: 12.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  poppinsText(
                    text: bookingData['returnFromTime'],
                    size: 15.0,
                    fontBold: FontWeight.w400,
                  ),
                  const Expanded(
                    child: Divider(
                      color: Constants.secondaryColor,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                  Transform.rotate(
                    angle: 90 * 3.1415 / 180,
                    child: const Icon(
                      Icons.flight,
                      color: Constants.primaryColor,
                      size: 25,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Constants.secondaryColor,
                      indent: 10,
                      endIndent: 20,
                    ),
                  ),
                  poppinsText(
                    text: bookingData['returnToTime'],
                    size: 15.0,
                    fontBold: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  poppinsText(
                    text: bookingData['returnFromCity'],
                    color: Constants.secondaryColor,
                  ),
                  poppinsText(
                    text: bookingData['returnToCity'],
                    color: Constants.secondaryColor,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.event_seat,
                        color: Constants.secondaryColor,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      poppinsText(
                        text: bookingData['cabin'],
                        color: Constants.secondaryColor,
                        size: 12.0,
                        fontBold: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 10),
                  poppinsText(
                    text: "\$" + bookingData['price'],
                    color: Constants.secondaryColor,
                    fontBold: FontWeight.w600,
                    size: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ) : Container(),
    );
  }
}

class VacationCard extends StatelessWidget {
  final dynamic bookingData;

  const VacationCard({Key? key, required this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = bookingData['imageUrl'];
    final String packageName = bookingData['packageName'];
    final String destination = bookingData['destination'];

    return InkWell(
      onTap: () {
        PackageBooking packageBooking = PackageBooking.fromJson(bookingData);
        Get.to(() => ViewBooking(
              packageBooking: packageBooking,
            ));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      poppinsText(
                        text: packageName,
                        size: 14.0,
                        fontBold: FontWeight.w700,
                      ),
                      const SizedBox(height: 10),
                      poppinsText(
                        text: destination,
                        size: 12.0,
                        color: const Color(0xff616161),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.49,
                        child: poppinsText(
                            text: "Ends: ${bookingData['vacationEndDate']}",
                            color: Constants.primaryColor,
                            fontBold: FontWeight.w500,
                            size: 12.0),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    Key? key,
    required this.date,
    required this.widget,
  }) : super(key: key);
  final String date;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 5),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black)),
            ),
            poppinsText(text: date, fontBold: FontWeight.w500),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 17),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(
            color: Colors.grey,
          ))),
          child: widget,
        ),
      ],
    );
  }
}
