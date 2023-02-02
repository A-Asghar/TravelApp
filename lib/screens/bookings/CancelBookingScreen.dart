import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/tealButton.dart';
import '../Profile.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({Key? key}) : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: 25,
          ),
        ),
        title: Text(
          "Cancel Hotel Booking",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please select a payment refund method (only\n80% will be refunded).",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // card(
                      //   'assets/images/card.png',
                      //   "•••• •••• •••• •••• 4679",
                      //   Constants.primaryColor,
                      // ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Paid: \$479.5   ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                    color: const Color(0xff424242),
                  ),
                ),
                Text(
                  "Refund: \$383.8",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 18,
                    color: const Color(0xff424242),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TealButton(
              text: "Confirm Cancellation",
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    buttonPadding: EdgeInsets.zero,
                    titlePadding: EdgeInsets.zero,
                    actionsPadding: EdgeInsets.zero,
                    insetPadding: const EdgeInsets.only(left: 30, right: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: Colors.white,
                    content: Container(
                      height: 400,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 180,
                            width: 185,
                            child: Image.asset(
                              'assets/images/p3.png',
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Successfull!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "You have successfully canceled your\norder. 80% funds will be returned to\nyour account",
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16,
                              height: 1.6,
                              color: const Color(0xff09101D),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            text: "OK",
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget card(String image, String text, Color color) {
  return Container(
    height: 80,
    width: Get.width,
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
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            text,
            style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
              fontSize: 18,
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Constants.primaryColor,
                width: 2.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundColor: color,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
