import 'package:flutter/material.dart';
import 'package:fyp/screens/bookings/FlightsOnGoingView.dart';
import 'package:fyp/screens/bookings/VacationsOnGoingView.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';
import 'NewView.dart';
import 'OnGoingView.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final documentController = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: poppinsText(
              text: 'My Bookings', size: 24.0, fontBold: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const NewView(),
      // Padding(
      //   padding: const EdgeInsets.only(left: 20, right: 20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const SizedBox(height: 20),
      //       GetX<DocumentController>(
      //         init: documentController,
      //         builder: (documentController) => Row(
      //           children: [
      //             // tapCard(
      //             //   "Hotels",
      //             //   documentController.isDocument.value == 0
      //             //       ? Constants.primaryColor
      //             //       : Colors.transparent,
      //             //   () {
      //             //     documentController.isDocument.value = 0;
      //             //   },
      //             // ),
      //             // const SizedBox(width: 14),
      //             // tapCard(
      //             //   "Flights",
      //             //   documentController.isDocument.value == 1
      //             //       ? Constants.primaryColor
      //             //       : Colors.transparent,
      //             //   () {
      //             //     documentController.isDocument.value = 1;
      //             //   },
      //             // ),
      //             // const SizedBox(width: 14),
      //             // tapCard(
      //             //   "Vacations",
      //             //   documentController.isDocument.value == 2
      //             //       ? Constants.primaryColor
      //             //       : Colors.transparent,
      //             //   () {
      //             //     documentController.isDocument.value = 2;
      //             //   },
      //             // ),
      //             // const SizedBox(width: 14),
      //             tapCard(
      //               "NewView",
      //               documentController.isDocument.value == 0
      //                   ? Constants.primaryColor
      //                   : Colors.transparent,
      //               () {
      //                 documentController.isDocument.value = 0;
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       GetX<DocumentController>(
      //         init: documentController,
      //         builder: (documentController) =>
      //             documentController.isDocument.value == 0
      //                 ?
      //                 // ? const OnGoingView()
      //                 // : documentController.isDocument.value == 1
      //                 // ? const FlightsOnGoingView()
      //                 // : documentController.isDocument.value == 2
      //                 // ? const VacationsOnGoingView()
      //                 const NewView()
      //                 : const NewView(),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget tapCard(String text, Color bgColor, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Constants.primaryColor,
            ),
          ),
          child: Center(
            child: poppinsText(
                text: text,
                size: 15.0,
                color: bgColor == Colors.transparent
                    ? Constants.primaryColor
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}

class DocumentController extends GetxController {
  RxInt isDocument = 0.obs;
}
