import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/FlightBooking.dart';
import 'package:fyp/models/HotelBooking.dart';
import 'package:fyp/models/PackageBooking.dart';
import 'package:fyp/providers/UserProvider.dart';
import 'package:fyp/widgets/card_view.dart';
import 'package:fyp/widgets/flight_card_view2.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:get/get.dart';

class ViewBooking extends StatefulWidget {
  ViewBooking(
      {super.key, this.flightBooking, this.hotelBooking, this.packageBooking});
  FlightBooking? flightBooking;
  HotelBooking? hotelBooking;
  PackageBooking? packageBooking;

  @override
  State<ViewBooking> createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBooking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Constants.secondaryColor,
          ),
        ),
        title: poppinsText(
            text: 'View Booking', size: 24.0, fontBold: FontWeight.w500),
        centerTitle: true,
      ),
      body: widget.packageBooking != null
          ? PackageBookingLayout(packageBooking: widget.packageBooking!)
          : widget.flightBooking != null
              ? FlightBookingLayout(
                  flightBooking: widget.flightBooking!,
                )
              : HotelBookingLayout(hotelBooking: widget.hotelBooking!),
    ));
  }
}

class PackageBookingLayout extends StatefulWidget {
  const PackageBookingLayout({super.key, required this.packageBooking});

  final PackageBooking packageBooking;

  @override
  State<PackageBookingLayout> createState() => _PackageBookingLayoutState();
}

class _PackageBookingLayoutState extends State<PackageBookingLayout> {
  double serviceFeeRate = 10.0;
  double serviceFeeAmount = 0.0;
  UserProvider controller = Get.put(UserProvider());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardView2(
                      packageBooking: widget.packageBooking,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          text: 'Summary',
                                          color: Constants.secondaryColor,
                                          fontBold: FontWeight.w500,
                                          size: 16.0),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Phone number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Start day",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "End day",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Guests",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 42),
                                      Text(
                                        controller.user!.name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        controller.user!.phoneNumber ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.packageBooking.vacationStartDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.packageBooking.vacationEndDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.packageBooking.adults,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          text: 'Charges',
                                          color: Constants.secondaryColor,
                                          fontBold: FontWeight.w500,
                                          size: 16.0),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Package price",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Service Charges",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      // const SizedBox(height: 20),
                                      // Text(
                                      //   "Discount amount",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .caption!
                                      //       .copyWith(
                                      //         fontSize: 16,
                                      //       ),
                                      // ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      Text(
                                        double.parse(
                                                widget.packageBooking.price)
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "${serviceFeeRate.round() ?? ""}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      // const SizedBox(height: 20),
                                      // Text(
                                      //   "\$$serviceFeeAmount",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyText1!
                                      //       .copyWith(fontSize: 16),
                                      // ),
                                      const SizedBox(height: 20),
                                      Text(
                                        (double.parse(widget
                                                    .packageBooking.price) +
                                                (serviceFeeRate /
                                                    100 *
                                                    double.parse(widget
                                                        .packageBooking.price)))
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class HotelBookingLayout extends StatefulWidget {
  const HotelBookingLayout({super.key, required this.hotelBooking});

  final HotelBooking hotelBooking;

  @override
  State<HotelBookingLayout> createState() => _HotelBookingLayoutState();
}

class _HotelBookingLayoutState extends State<HotelBookingLayout> {
  double serviceFeeRate = 10.0;
  double serviceFeeAmount = 0.0;
  UserProvider controller = Get.put(UserProvider());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardView2(
                      hotelBooking: widget.hotelBooking,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          text: 'Summary',
                                          color: Constants.secondaryColor,
                                          fontBold: FontWeight.w500,
                                          size: 16.0),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Phone number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Start day",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "End day",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Guest",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      Text(
                                        controller.user?.name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        controller.user?.phoneNumber ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.hotelBooking.hotelCheckInDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.hotelBooking.hotelCheckOutDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.hotelBooking.adults,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          text: 'Charges',
                                          color: Constants.secondaryColor,
                                          fontBold: FontWeight.w500,
                                          size: 16.0),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Hotel charges",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Service Charges",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      // const SizedBox(height: 20),
                                      // Text(
                                      //   "Discounted amount",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .caption!
                                      //       .copyWith(
                                      //         fontSize: 16,
                                      //       ),
                                      // ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      Text(
                                        ((double.parse(widget
                                                        .hotelBooking.price) *
                                                    100) /
                                                110)
                                            .toStringAsFixed(2)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "${serviceFeeRate.round()}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      // const SizedBox(height: 20),
                                      // Text(
                                      //   "\$${discountAmount.toStringAsFixed(2)}",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyText1!
                                      //       .copyWith(fontSize: 16),
                                      // ),
                                      const SizedBox(height: 20),
                                      Text(
                                        double.parse(widget.hotelBooking.price)
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class FlightBookingLayout extends StatefulWidget {
  const FlightBookingLayout({super.key, required this.flightBooking});

  final FlightBooking flightBooking;

  @override
  State<FlightBookingLayout> createState() => _FlightBookingLayoutState();
}

class _FlightBookingLayoutState extends State<FlightBookingLayout> {
  double serviceFeeRate = 10.0;
  double serviceFeeAmount = 0.0;
  UserProvider controller = Get.put(UserProvider());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlightCardView2(flightBooking: widget.flightBooking),
                    widget.flightBooking.returnFlightExists
                        ? ReturnFlightCardView2(
                            flightBooking: widget.flightBooking)
                        : Container(),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          text: 'Summary',
                                          color: Constants.secondaryColor,
                                          fontBold: FontWeight.w500,
                                          size: 16.0),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Phone number',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Depart date",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      widget.flightBooking.returnFlightExists
                                          ? Text(
                                              "Return date",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    fontSize: 16,
                                                  ),
                                            )
                                          : Container(),
                                      widget.flightBooking.returnFlightExists
                                          ? const SizedBox(height: 20)
                                          : const SizedBox(),
                                      Text(
                                        "Passengers",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 42),
                                      Text(
                                        controller.user?.name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        controller.user?.phoneNumber ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget
                                            .flightBooking.flightDepartureDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      widget.flightBooking.returnFlightExists
                                          ? Text(
                                              widget.flightBooking
                                                  .flightReturnDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 16),
                                            )
                                          : Container(),
                                      widget.flightBooking.returnFlightExists
                                          ? const SizedBox(height: 20)
                                          : Container(),
                                      Text(
                                        widget.flightBooking.adults,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          text: 'Charges',
                                          color: Constants.secondaryColor,
                                          fontBold: FontWeight.w500,
                                          size: 16.0),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Package price",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Service Charges",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Total",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 40),
                                      Text(
                                        ((double.parse(widget
                                                        .flightBooking.price) *
                                                    100) /
                                                110)
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "${serviceFeeRate.round()}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      // const SizedBox(height: 20),
                                      // Text(
                                      //   "\$${discountAmount.toStringAsFixed(2)}",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyText1!
                                      //       .copyWith(fontSize: 16),
                                      // ),
                                      const SizedBox(height: 20),
                                      Text(
                                        double.parse(widget.flightBooking.price)
                                            .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
