import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';

class CompletedView extends StatefulWidget {
  const CompletedView({Key? key}) : super(key: key);

  @override
  State<CompletedView> createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.only(bottom: 60),
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
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
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                index == 0
                                    ? 'assets/images/d4.png'
                                    : index == 1
                                        ? 'assets/images/d5.png'
                                        : 'assets/images/d6.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            poppinsText(
                              text: index == 0
                                  ? "Bulgari Resort"
                                  : index == 1
                                      ? "Hotel Martinez Cannes"
                                      : "Faena Miami Beach",
                              size: 18.0,
                              fontBold: FontWeight.w700,
                            ),
                            const SizedBox(height: 15),
                            poppinsText(
                              text: index == 0
                                  ? "Paris, France"
                                  : index == 1
                                      ? "Amsterdam, Netherlands"
                                      : "Rome, Italia",
                              size: 14.0,
                              color: const Color(0xff616161),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 24,
                              width: 72,
                              decoration: BoxDecoration(
                                color: Constants.primaryColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: poppinsText(
                                  text: "Completed",
                                  size: 10.0,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Color(0xffEEEEEE)),
                    const SizedBox(height: 15),
                    Container(
                      height: 34,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.primaryColor.withOpacity(0.20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Constants.primaryColor,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                size: 10,
                              ),
                            ),
                            const SizedBox(width: 14),
                            poppinsText(
                              text: "Yeay, you have completed it!",
                              size: 10.0,
                              color: Constants.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
