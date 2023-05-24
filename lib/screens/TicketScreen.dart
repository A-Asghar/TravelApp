import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:get/get.dart';

import '../providers/UserProvider.dart';
import '../widgets/poppinsText.dart';
import '../widgets/tealButton.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

final UserProvider controller = Get.put(UserProvider());

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Theme.of(context).textTheme.bodyText1!.color!,
          ),
        ),
        title: poppinsText(text: "Ticket", size: 24.0, fontBold: FontWeight.w500),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
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
                          Center(
                            child: poppinsText(
                                text: "Royale President Hotel", size: 20.0),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              height: 224,
                              width: 224,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/qr.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              customColumn("Name",
                                  controller.user?.name ?? "Abdullah Amin"),
                              const SizedBox(width: 14),
                              customColumn(
                                  "Phone Number",
                                  controller.user?.phoneNumber ??
                                      "+1 111 467 378 399"),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              customColumn("Check in", "Dec 16, 2024"),
                              const SizedBox(width: 14),
                              customColumn("Check out", "Dec 20, 2024"),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              customColumn("Hotel", "Royale President"),
                              const SizedBox(width: 14),
                              customColumn("Guest", "3"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Center(
              child: TealButton(
                text: "Download Ticket",
                onPressed: () {},
                bgColor: Constants.primaryColor, txtColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget customColumn(String text1, String text2) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          poppinsText(
            text: text1,
            size: 16.0,
            color: const Color(0xff757575),
          ),
          const SizedBox(height: 8),
          poppinsText(text: text2, size: 16.0, fontBold: FontWeight.w400),
        ],
      ),
    );
  }
}
