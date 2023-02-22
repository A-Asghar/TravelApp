import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp/screens/bookings/FlightsOnGoingView.dart';
import 'package:fyp/screens/bookings/VacationsOnGoingView.dart';
import 'package:fyp/screens/bookings/VacationsCompletedView.dart';
import 'package:fyp/screens/bookings/VacationsCanceledView.dart';

import 'package:fyp/screens/bookings/FlightsCompletedView.dart';
import 'package:fyp/screens/bookings/FlightsCanceledView.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';
import 'Bookings.dart';
import 'CanceledView.dart';
import 'CompletedView.dart';
import 'FlightBookings.dart';
import 'OnGoingView.dart';

class VacationsBookings extends StatefulWidget {
  const VacationsBookings({Key? key}) : super(key: key);

  @override
  State<VacationsBookings> createState() => _VacationsBookingsState();
}

class _VacationsBookingsState extends State<VacationsBookings> {
  final documentController1 = Get.put(DocumentController1());

  String selectedname ='Packages';
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  poppinsText(
                      text: 'My Bookings', size: 14.0, fontBold: FontWeight.w600),
                  DropdownButton<String>(
                    value: selectedname,
                    items: [
                      DropdownMenuItem(
                        child: poppinsText(
                            text: 'Hotel', size: 14.0, fontBold: FontWeight.w600),
                        value: "Hotel",
                      ),
                      DropdownMenuItem(
                        child: poppinsText(
                            text: 'Flight', size: 14.0, fontBold: FontWeight.w600),
                        value: "Flight",
                      ),
                      DropdownMenuItem(

                        child: poppinsText(
                            text: 'Packages', size: 14.0, fontBold: FontWeight.w600),
                        value: "Packages",
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        Navigator.of(context).pop();
                        selectedname = value!;
                        if( value == "Hotel"){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Bookings(),

                          ));
                        }else if(value == "Flight"){
                          //Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FlightBookings(),
                          ));
                        }else if(value == "Packages"){
                         // Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VacationsBookings(),
                          ));
                        }
                      });
                    },

                  ),

                ],
              ),
            ),
            const SizedBox(height: 20),
            GetX<DocumentController1>(
              init: documentController1,
              builder: (documentController1) => Row(
                children: [
                  tapCard(
                    "Ongoing",
                    documentController1.isDocument.value == 0
                        ? Constants.primaryColor
                        : Colors.transparent,
                        () {
                      documentController1.isDocument.value = 0;
                    },
                  ),
                  const SizedBox(width: 14),
                  tapCard(
                    "Completed",
                    documentController1.isDocument.value == 1
                        ? Constants.primaryColor
                        : Colors.transparent,
                        () {
                      documentController1.isDocument.value = 1;
                    },
                  ),
                  const SizedBox(width: 14),
                  tapCard(

                    "Canceled",
                    documentController1.isDocument.value == 2
                        ? Constants.primaryColor
                        : Colors.transparent,
                        () {
                      documentController1.isDocument.value = 2;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GetX<DocumentController1>(
              init: documentController1,
              builder: (documentController1) =>
              documentController1.isDocument.value == 0
                  ? const VacationsOnGoingView()
                  : documentController1.isDocument.value == 1
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

class DocumentController1 extends GetxController {
  RxInt isDocument = 0.obs;
}
