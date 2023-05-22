import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/models/Flight.dart';
import 'package:fyp/models/FlightBooking.dart';
import 'package:fyp/models/HotelBooking.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/models/PackageBooking.dart';
import 'package:fyp/models/PropertySearchListings.dart';
import 'package:fyp/models/PropertyUnits.dart';
import 'package:fyp/network/BookingNetwork.dart';
import 'package:fyp/providers/FlightSearchProvider.dart';
import 'package:fyp/providers/HotelSearchProvider.dart';
import 'package:fyp/providers/UserProvider.dart';
import 'package:fyp/screens/BottomNavBar.dart';
import 'package:fyp/widgets/card_view.dart';
import 'package:fyp/widgets/flight_card_view.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  ConfirmPaymentScreen(
      {Key? key, this.unit, this.package, this.property, this.flight})
      : super(key: key);
  Unit? unit;
  Package? package;
  PropertySearchListing? property;
  Flight? flight;

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
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
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              title: poppinsText(
                  text: 'Payment', size: 24.0, fontBold: FontWeight.w500),
              centerTitle: true,
            ),
            body: widget.package != null
                ? PackagePaymentLayout(package: widget.package!)
                : widget.flight != null
                    ? FlightPaymentLayout(
                        flight: widget.flight!,
                      )
                    : HotelPaymentLayout(
                        unit: widget.unit!,
                        property: widget.property!,
                      )),
      ),
    );
  }
}

class PackagePaymentLayout extends StatefulWidget {
  const PackagePaymentLayout({super.key, required this.package});

  final Package package;

  @override
  State<PackagePaymentLayout> createState() => _PackagePaymentLayoutState();
}

class _PackagePaymentLayoutState extends State<PackagePaymentLayout> {
  double serviceFeeRate = 10.0;
  double serviceFeeAmount = 0.0;
  bool isLoading = false;
  String travelerId = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic>? paymentIntent;
  UserProvider controller = Get.put(UserProvider());
  BookingNetwork bn = BookingNetwork();

  double calculateDiscountedPrice(double discountedRate) {
    double discountedAmount =
        (discountedRate / 100) * widget.package.packagePrice;
    return discountedAmount;
  }

  @override
  void initState() {
    super.initState();
    serviceFeeAmount = calculateDiscountedPrice(serviceFeeRate);
  }

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
                    CardView(
                      package: widget.package,
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
                                        DateFormat('MMM dd, yyyy').format(
                                                DateTime.parse(widget
                                                    .package.startDate)) ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        DateFormat('MMM dd, yyyy')
                                                .format(DateTime.parse(widget
                                                        .package.startDate)
                                                    .add(Duration(
                                                        days: widget.package
                                                            .numOfDays)))
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        widget.package.adults.toString() ?? "",
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
                                        "\$${widget.package.packagePrice ?? ""}",
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
                                        "\$${widget.package.packagePrice + serviceFeeAmount}",
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
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryColor,
                  ),
                )
              : Center(
                  child: TealButton(
                    text: "Pay Now",
                    onPressed: () async {
                      var bookingId = Random().nextInt(900000000) + 100000000;
                      double totalAmount =
                          widget.package.packagePrice + serviceFeeAmount;
                      setState(() => isLoading = true);
                      await makePayment(totalAmount.toInt().toString());
                      await bn.bookPackage(
                        packageBooking: PackageBooking(
                            packageName: widget.package.packageName,
                            bookingId: bookingId.toString(),
                            bookingDate: Constants.convertDate(DateTime.now()),
                            travelerId: travelerId,
                            travelAgencyId: widget.package.travelAgencyId,
                            packageId: widget.package.packageId,
                            price: widget.package.packagePrice.toString(),
                            adults: widget.package.adults.toString(),
                            destination: widget.package.destination,
                            imageUrl: widget.package.imgUrls[0],
                            vacationStartDate:
                                formatDate(widget.package.startDate),
                            vacationEndDate: DateFormat('MMM dd, yyyy')
                                .format(DateTime.parse(widget.package.startDate)
                                    .add(Duration(
                                        days: widget.package.numOfDays)))
                                .toString()),
                      );
                      setState(() => isLoading = false);
                    },
                    bgColor: Constants.primaryColor,
                    txtColor: Colors.white,
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  //Gotten from payment intent
                  style: ThemeMode.system,
                  googlePay: const PaymentSheetGooglePay(
                      merchantCountryCode: 'US',
                      currencyCode: 'USD',
                      testEnv: true),
                  applePay: const PaymentSheetApplePay(
                      merchantCountryCode: 'US',
                      buttonType: PlatformButtonType.book),
                  appearance: const PaymentSheetAppearance(
                    primaryButton: PaymentSheetPrimaryButtonAppearance(
                        colors: PaymentSheetPrimaryButtonTheme(
                      dark: PaymentSheetPrimaryButtonThemeColors(
                          background: Constants.primaryColor),
                      light: PaymentSheetPrimaryButtonThemeColors(
                          background: Constants.primaryColor),
                    )),
                    shapes: PaymentSheetShape(
                      borderRadius: 10,
                    ),
                  ),
                  customFlow: true,
                  merchantDisplayName: 'Ali Asghar'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MygtvITbvfdqJloHb08cW1oA7brS4P3VzR2mBkv8z1FPHhbfLFEMfgkKE5LrOPcA5A4dox6n6Zv8n4SZW51ru8500H751CCni',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Something went wrong!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            buttonPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.only(left: 30, right: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: Container(
              height: 520,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Constants.primaryColor),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 150,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Payment Successfull!",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Successfully made payment and booking",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          height: 1.6,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TealButton(
                    text: "Continue",
                    onPressed: () {
                      Get.to(() => BottomNavBar(),
                          transition: Transition.downToUp);
                    },
                    bgColor: Constants.primaryColor,
                    txtColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );

        paymentIntent = null;
      }).onError((error, stackTrace) {
        setState(() => isLoading = false);
        print('Error is:---> $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Something went wrong!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ));
      });
    } on StripeException catch (e) {
      setState(() => isLoading = false);
      print('Error is:---> $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print('$e');
    }
  }
}

class HotelPaymentLayout extends StatefulWidget {
  const HotelPaymentLayout(
      {super.key, required this.unit, required this.property});

  final Unit unit;
  final PropertySearchListing property;

  @override
  State<HotelPaymentLayout> createState() => _HotelPaymentLayoutState();
}

class _HotelPaymentLayoutState extends State<HotelPaymentLayout> {
  double discountedRate = 10.0;
  double discountAmount = 0.0;
  Map<String, dynamic>? paymentIntent;
  bool isLoading = false;
  String travelerId = FirebaseAuth.instance.currentUser!.uid;
  UserProvider controller = Get.put(UserProvider());
  BookingNetwork bn = BookingNetwork();

  double calculateDiscountedPrice(double discountedRate) {
    double discountedAmount = (discountedRate / 100) *
        widget.unit.ratePlans![0].priceDetails![0].price!.lead!.amount;
    return discountedAmount;
  }

  @override
  void initState() {
    super.initState();
    discountAmount = calculateDiscountedPrice(discountedRate);
  }

  @override
  Widget build(BuildContext context) {
    var hotelProvider = context.watch<HotelSearchProvider>();
    double hotelCharges =
        widget.unit.ratePlans![0].priceDetails![0].price!.lead!.amount;
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
                    widget.unit.unitGallery!.gallery != null
                        ? CardView(
                            unit: widget.unit,
                            property: widget.property,
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
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
                                        hotelProvider.checkIn ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        hotelProvider.checkOut ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        hotelProvider.adults.toString() ?? "",
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
                                        "\$${hotelCharges.toStringAsFixed(2)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "${discountedRate.round()}%",
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
                                        "\$${(hotelCharges + discountAmount).toStringAsFixed(2)}",
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
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryColor,
                  ),
                )
              : Center(
                  child: TealButton(
                    text: "Pay Now",
                    onPressed: () async {
                      var bookingId = Random().nextInt(900000000) + 100000000;
                      double totalAmount = hotelCharges - discountAmount;
                      setState(() => isLoading = true);
                      await makePayment(totalAmount.toInt().toString());
                      await bn.bookHotelRoom(
                        hotelBooking: HotelBooking(
                          bookingId: bookingId.toString(),
                          bookingDate: Constants.convertDate(DateTime.now()),
                          travelerId: travelerId,
                          hotelId: widget.property.id!,
                          hotelRoomId: widget.unit.id!,
                          hotelName: widget.property.name ?? "",
                          hotelLocation:
                              widget.property.neighborhood?.name ?? "",
                          imageUrl:
                              widget.property.propertyImage?.image?.url ?? "",
                          hotelCheckInDate: formatDate(
                              context.read<HotelSearchProvider>().checkIn),
                          hotelCheckOutDate: formatDate(
                              context.read<HotelSearchProvider>().checkOut),
                        ),
                      );
                      setState(() => isLoading = false);
                    },
                    bgColor: Constants.primaryColor,
                    txtColor: Colors.white,
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  //Gotten from payment intent
                  style: ThemeMode.system,
                  googlePay: const PaymentSheetGooglePay(
                      merchantCountryCode: 'US',
                      currencyCode: 'USD',
                      testEnv: true),
                  applePay: const PaymentSheetApplePay(
                      merchantCountryCode: 'US',
                      buttonType: PlatformButtonType.book),
                  appearance: const PaymentSheetAppearance(
                    primaryButton: PaymentSheetPrimaryButtonAppearance(
                        colors: PaymentSheetPrimaryButtonTheme(
                      dark: PaymentSheetPrimaryButtonThemeColors(
                          background: Constants.primaryColor),
                      light: PaymentSheetPrimaryButtonThemeColors(
                          background: Constants.primaryColor),
                    )),
                    shapes: PaymentSheetShape(
                      borderRadius: 10,
                    ),
                  ),
                  customFlow: true,
                  merchantDisplayName: 'ExploreEase'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MygtvITbvfdqJloHb08cW1oA7brS4P3VzR2mBkv8z1FPHhbfLFEMfgkKE5LrOPcA5A4dox6n6Zv8n4SZW51ru8500H751CCni',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Something went wrong!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            buttonPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.only(left: 30, right: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: Container(
              height: 520,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Constants.primaryColor),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 150,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Payment Successfull!",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Successfully made payment and booking",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          height: 1.6,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TealButton(
                    text: "Continue",
                    onPressed: () {
                      Get.to(() => BottomNavBar(),
                          transition: Transition.downToUp);
                    },
                    bgColor: Constants.primaryColor,
                    txtColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );

        paymentIntent = null;
      }).onError((error, stackTrace) {
        setState(() => isLoading = false);
        print('Error is:---> $error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Something went wrong!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ));
      });
    } on StripeException catch (e) {
      setState(() => isLoading = false);
      print('Error is:---> $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print('$e');
    }
  }
}

class FlightPaymentLayout extends StatefulWidget {
  const FlightPaymentLayout({super.key, required this.flight});

  final Flight flight;

  @override
  State<FlightPaymentLayout> createState() => _FlightPaymentLayoutState();
}

class _FlightPaymentLayoutState extends State<FlightPaymentLayout> {
  double discountedRate = 10.0;
  double discountAmount = 0.0;
  bool isLoading = false;
  String travelerId = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic>? paymentIntent;
  UserProvider controller = Get.put(UserProvider());
  BookingNetwork bn = BookingNetwork();

  double calculateDiscountedPrice(double discountedRate) {
    double discountedAmount =
        (discountedRate / 100) * double.parse(widget.flight.price.total);
    return discountedAmount;
  }

  @override
  void initState() {
    super.initState();
    discountAmount = calculateDiscountedPrice(discountedRate);
  }

  @override
  Widget build(BuildContext context) {
    var flightProvider = context.watch<FlightSearchProvider>();
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
                    FlightCardView(
                      flight: widget.flight,
                      flightProvider: flightProvider,
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
                                        "Depart date",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      DateTime.parse(context
                                                      .read<
                                                          FlightSearchProvider>()
                                                      .returnDate)
                                                  .day !=
                                              DateTime.now().day
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
                                      DateTime.parse(context
                                                      .read<
                                                          FlightSearchProvider>()
                                                      .returnDate)
                                                  .day !=
                                              DateTime.now().day
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
                                        DateFormat('MMM dd, yyyy').format(
                                                DateTime.parse(flightProvider
                                                    .departDate)) ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      DateTime.parse(context
                                                      .read<
                                                          FlightSearchProvider>()
                                                      .returnDate)
                                                  .day !=
                                              DateTime.now().day
                                          ? Text(
                                              DateFormat('MMM dd, yyyy')
                                                      .format(DateTime.parse(
                                                          flightProvider
                                                              .returnDate))
                                                      .toString() ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 16),
                                            )
                                          : Container(),
                                      DateTime.parse(context
                                                      .read<
                                                          FlightSearchProvider>()
                                                      .returnDate)
                                                  .day !=
                                              DateTime.now().day
                                          ? const SizedBox(height: 20)
                                          : Container(),
                                      Text(
                                        flightProvider.adults.toString() ?? "",
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
                                        "\$${double.parse(widget.flight.price.total ?? "0.0")}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 16),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "${discountedRate.round()}%",
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
                                        "\$${(double.parse(widget.flight.price.total ?? "0.0") + discountAmount).toStringAsFixed(2)}",
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
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryColor,
                  ),
                )
              : Center(
                  child: TealButton(
                    text: "Pay Now",
                    onPressed: () async {
                      var bookingId = Random().nextInt(900000000) + 100000000;
                      var flightId = Random().nextInt(900000000) + 100000000;
                      double totalAmount =
                          double.parse(widget.flight.price.total) -
                              discountAmount;
                      setState(() => isLoading = true);
                      await makePayment(totalAmount.toInt().toString());
                      await bn.bookFlight(
                        flightBooking: FlightBooking(
                          bookingId: bookingId.toString(),
                          bookingDate: Constants.convertDate(DateTime.now()),
                          travelerId: travelerId,
                          flightId: flightId.toString(),
                          cabin: widget.flight.fareDetailsBySegment[0].cabin,
                          flightDuration: widget.flight.itineraries[0].duration
                              .replaceAll('PT', '')
                              .replaceAll('H', 'H ')
                              .toLowerCase(),
                          fromCity: widget.flight.itineraries[0].segments[0]
                              .departure.iataCode,
                          toCity: widget.flight.itineraries[0].segments.last
                              .arrival.iataCode,
                          fromTime: Constants.convertTime(widget
                              .flight.itineraries[0].segments[0].departure.at),
                          toTime: Constants.convertTime(widget
                              .flight.itineraries[0].segments[0].arrival.at),
                          price: widget.flight.price.total,
                          flightDepartureDate: formatDate(context.read<FlightSearchProvider>().departDate),
                          flightReturnDate: formatDate(context.read<FlightSearchProvider>().returnDate),
                          returnFlightExists: widget.flight.itineraries.length > 1,
                          returnFlightDuration: widget.flight.itineraries.length > 1 ? widget.flight.itineraries[1]?.duration?.replaceAll('PT', '')?.replaceAll('H', 'H ')?.toLowerCase() ?? '' : '',
                          returnFromCity: widget.flight.itineraries.length > 1 ? widget.flight.itineraries[1]?.segments[0]?.departure?.iataCode ?? '' : '',
                          returnToCity: widget.flight.itineraries.length > 1 ? widget.flight.itineraries[1]?.segments.last?.arrival?.iataCode ?? '' : '',
                          returnFromTime: widget.flight.itineraries.length > 1 ? Constants.convertTime(widget.flight.itineraries[1]?.segments[0]?.departure?.at) ?? '' : '',
                          returnToTime: widget.flight.itineraries.length > 1 ? Constants.convertTime(widget.flight.itineraries[1]?.segments.last?.arrival?.at) ?? '' : '',

                        ),
                      );
                      setState(() => isLoading = false);
                    },
                    bgColor: Constants.primaryColor,
                    txtColor: Colors.white,
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  //Gotten from payment intent
                  style: ThemeMode.system,
                  googlePay: const PaymentSheetGooglePay(
                      merchantCountryCode: 'US',
                      currencyCode: 'USD',
                      testEnv: true),
                  applePay: const PaymentSheetApplePay(
                      merchantCountryCode: 'US',
                      buttonType: PlatformButtonType.book),
                  appearance: const PaymentSheetAppearance(
                    primaryButton: PaymentSheetPrimaryButtonAppearance(
                        colors: PaymentSheetPrimaryButtonTheme(
                      dark: PaymentSheetPrimaryButtonThemeColors(
                          background: Constants.primaryColor),
                      light: PaymentSheetPrimaryButtonThemeColors(
                          background: Constants.primaryColor),
                    )),
                    shapes: PaymentSheetShape(
                      borderRadius: 10,
                    ),
                  ),
                  customFlow: true,
                  merchantDisplayName: 'Ali Asghar'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MygtvITbvfdqJloHb08cW1oA7brS4P3VzR2mBkv8z1FPHhbfLFEMfgkKE5LrOPcA5A4dox6n6Zv8n4SZW51ru8500H751CCni',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Something went wrong!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            buttonPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.only(left: 30, right: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: Container(
              height: 520,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Constants.primaryColor),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 150,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Payment Successfull!",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Successfully made payment and booking",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          height: 1.6,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TealButton(
                    text: "Continue",
                    onPressed: () {
                      Get.to(() => BottomNavBar(),
                          transition: Transition.downToUp);
                    },
                    bgColor: Constants.primaryColor,
                    txtColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );

        paymentIntent = null;
      }).onError((error, stackTrace) {
        setState(() => isLoading = false);
        print('Error is:---> $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Something went wrong!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ));
      });
    } on StripeException catch (e) {
      setState(() => isLoading = false);
      print('Error is:---> $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print('$e');
    }
  }
}

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({super.key});

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      buttonPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      insetPadding: const EdgeInsets.only(left: 30, right: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Container(
        height: 520,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: 180,
              width: 185,
              child: Icon(
                Icons.check_circle_rounded,
                color: Constants.primaryColor,
                size: 150,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Payment Successfull!",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.teal,
                  ),
            ),
            const SizedBox(height: 15),
            Text(
              "Successfully made payment and booking",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    height: 1.6,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TealButton(
              text: "View Ticket",
              onPressed: () {
                // Get.to(
                //   const TicketScreen(),
                //   transition: Transition.rightToLeft,
                // );
              },
              bgColor: Constants.primaryColor,
              txtColor: Colors.white,
            ),
            TealButton(
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
              bgColor: Colors.red,
              txtColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

String formatDate(String date) {
  final DateTime parsedDate = DateTime.parse(date);
  final formattedDate = DateFormat('MMM dd, yyyy').format(parsedDate);
  return formattedDate;
}
