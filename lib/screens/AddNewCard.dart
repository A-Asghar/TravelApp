import 'package:flutter/material.dart';
import 'package:fyp/widgets/tealButton.dart';

import 'bookings/CancelBookingScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          // Get.to(
                          //   const AddNewCardScreen(),
                          //   transition: Transition.rightToLeft,
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Methods",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              "Add New Card",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 14,
                                    color: Colors.teal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Pay with Debit/Credit card",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // card(
                      //     "assets/images/card.png",
                      //   "•••• •••• •••• •••• 4679",
                      //   Colors.teal),
                    ],
                  ),
                ],
              ),
            ),
            TealButton(text: 'Continue', onPressed: () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
