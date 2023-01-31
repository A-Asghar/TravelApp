// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/tealButton.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

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
            Icons.arrow_back,
            color: Theme.of(context).textTheme.bodyText1!.color!,
          ),
        ),
        title: Text(
          "Ticket",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
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
                      color:
                      // AppTheme.isLightTheme == true
                      //     ? const Color(0xffFAFAFA)
                      //     :
                      Colors.white,
                      border: Border.all(
                        color:
                        // AppTheme.isLightTheme == true
                        //     ? const Color(0xffEEEEEE)
                        //     :
                        Colors.white.withOpacity(0.1),
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
                            child: Text(
                              "Royale President Hotel",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
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
                              customColumn("Name", "Abdullah Amin"),
                              const SizedBox(width: 14),
                              customColumn(
                                  "Phone Number", "+1 111 467 378 399"),
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
            TealButton(
              text: "Download Ticket",
              onPressed: () {},
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
          Text(
            text1,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              color: const Color(0xff757575),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text2,
            style:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
