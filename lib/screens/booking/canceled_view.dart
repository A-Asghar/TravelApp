import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/poppinsText.dart';

class CanceledView extends StatefulWidget {
  const CanceledView({Key? key}) : super(key: key);

  @override
  State<CanceledView> createState() => _CanceledViewState();
}

class _CanceledViewState extends State<CanceledView> {
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
                                    ? 'assets/images/d7.png'
                                    : index == 1
                                        ? 'assets/images/d8.png'
                                        : 'assets/images/d9.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: poppinsText(
                                text: index == 0
                                    ? "Palms Casino Resort"
                                    : index == 1
                                        ? "The Mark Hotel"
                                        : "Palazzo Versace Dubai",
                                size: 18.0,
                                fontBold: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: poppinsText(
                                text: index == 0
                                    ? "London, United Kingdom"
                                    : index == 1
                                        ? "Luxemburg, Germany"
                                        : "Dubai, United Arab Emirates",
                                size: 14.0,
                                color: const Color(0xff616161),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 24,
                              width: 121,
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xffF75555).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: poppinsText(
                                  text: "Canceled & Refunded",
                                  size: 10.0,
                                  color: const Color(0xffF75555),
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
                        color: const Color(0xffF75555).withOpacity(0.20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error,
                              color: Color(0xffF75555),
                              size: 20,
                            ),
                            const SizedBox(width: 14),
                            poppinsText(
                              text: "You canceled this hotel booking",
                              size: 10.0,
                              color: const Color(0xffF75555),
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
