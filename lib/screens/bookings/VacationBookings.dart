import 'package:flutter/material.dart';
import 'package:fyp/screens/bookings/VacationsCanceledView.dart';
import 'package:fyp/screens/bookings/VacationsCompletedView.dart';
import 'package:fyp/screens/bookings/VacationsOnGoingView.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';

class VacationsBookings extends StatefulWidget {
  const VacationsBookings({Key? key}) : super(key: key);

  @override
  State<VacationsBookings> createState() => _VacationsBookingsState();
}

class _VacationsBookingsState extends State<VacationsBookings> {
  final documentController1 = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 20),
            Container(
              padding: const EdgeInsets.only(left: 16),
              child: poppinsText(
                  text: 'My Bookings', size: 24.0, fontBold: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            GetX<DocumentController>(
              init: documentController1,
              builder: (documentController) => Row(
                children: [
                  tapCard(
                    "Ongoing",
                    documentController.isDocument.value == 0
                        ? Constants.primaryColor
                        : Colors.transparent,
                        () {
                      documentController.isDocument.value = 0;
                    },
                  ),
                  const SizedBox(width: 14),
                  tapCard(
                    "Completed",
                    documentController.isDocument.value == 1
                        ? Constants.primaryColor
                        : Colors.transparent,
                        () {
                      documentController.isDocument.value = 1;
                    },
                  ),
                  const SizedBox(width: 14),
                  tapCard(

                    "Canceled",
                    documentController.isDocument.value == 2
                        ? Constants.primaryColor
                        : Colors.transparent,
                        () {
                      documentController.isDocument.value = 2;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GetX<DocumentController>(
              init: documentController1,
              builder: (documentController) =>
              documentController.isDocument.value == 0
                  ? const VacationsOnGoingView()
                  : documentController.isDocument.value == 1
                  ? const VacationsCompletedView()
                  : const VacationsCanceledView(),
            ),
          ],
        ),
      ),
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
