import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fyp/widgets/card_view.dart';
import 'package:fyp/widgets/tealButton.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CardView(),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color:
                          // AppTheme.isLightTheme == true
                          //     ? Colors.white
                          //     :
                          Colors.white,
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
                                        Text(
                                          "December 16, 2024",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "December 20, 2024",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "3",
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
                          color:

                          // AppTheme.isLightTheme == true
                          //     ? Colors.white
                          //     :
                          Colors.white,
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
                                        Text(
                                          "Flight charges",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
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
                                          "Remaining",
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
                                        Text(
                                          "\$435.00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "\$400.00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "\$44.50",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "\$879.50",
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
                      const SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color:
                          // AppTheme.isLightTheme == true
                          //     ? Colors.white
                          //     :
                          Colors.white,
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
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/card.png",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                "•••• •••• •••• •••• 4679",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Text(
                                "Change",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                  fontSize: 16,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ],
              ),
            ),
            TealButton(
              text: "Confirm Payment",
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    backgroundColor:
                    // AppTheme.isLightTheme == true
                    //     ? Colors.white
                    //     :
                    Colors.white,
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
                        color:
                        // AppTheme.isLightTheme == true
                        //     ? Colors.white
                        //     :
                        Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 180,
                            width: 185,
                            child: Image.asset(
                              "assets/images/p3.png",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Payment Successfull!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Successfully made payment and\nhotel booking",
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
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
                          ),
                          //const SizedBox(height: 12),
                          TealButton(
                            text: "Cancel",
                            onPressed: () {
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
