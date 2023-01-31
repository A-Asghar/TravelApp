import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/Constants.dart';
import 'package:get/get.dart';

import '../../widgets/customTextField.dart';
import '../../widgets/filterView.dart';
import '../Details.dart';


class VacationSearchResults extends StatefulWidget {
  const VacationSearchResults({Key? key}) : super(key: key);

  @override
  State<VacationSearchResults> createState() => _VacationSearchResultsState();
}

class _VacationSearchResultsState extends State<VacationSearchResults> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
            key: scaffoldState,
            body:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
                  child: CustomTextField(
                    hintText: "Search",
                    textFieldController: TextEditingController(text: 'Vacations'),
                    prefix: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                        'assets/images/search.svg',
                      ),
                    ),
                    sufix: InkWell(
                      onTap: () {
                        // homeController.scaffoldKey.currentState!.showBottomSheet(
                        //   enableDrag: true,
                        //   backgroundColor:
                        //   Theme.of(context).appBarTheme.backgroundColor,
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(40),
                        //       topRight: Radius.circular(40),
                        //     ),
                        //   ),
                        //       (context) => const FilterView(),
                        // );
                      },
                      // child: Padding(
                      //   padding: EdgeInsets.all(14.0),
                      //   child: IconButton(
                      //     icon: Icon(Icons.filter_alt,color: Constants.primaryColor,),
                      //     onPressed: (){
                      //       scaffoldState.currentState!
                      //           .showBottomSheet(
                      //         enableDrag: true,
                      //         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(40),
                      //             topRight: Radius.circular(40),
                      //           ),
                      //         ),
                      //             (context) => const FilterView(),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Found (586,379)",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    physics: const ClampingScrollPhysics(),
                    padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          // Get.to(
                          //   const Details(detailsType: 'hotel',),
                          //   transition: Transition.rightToLeft,
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color:
                              //     const Color(0xff04060F).withOpacity(0.05),
                              //     blurRadius: 8,
                              //   )
                              // ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          index == 0
                                              ? 'assets/images/d1.png'
                                              : index == 1
                                              ? 'assets/images/d6.png'
                                              : index == 2
                                              ? 'assets/images/d2.png'
                                              : index == 3
                                              ? 'assets/images/d7.png'
                                              : 'assets/images/d8.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          index == 0
                                              ? "Istanbul"
                                              : index == 1
                                              ? "Paris"
                                              : index == 2
                                              ? "London"
                                              : "Italy",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          index == 0
                                              ? "Istanbul, Turkiye"
                                              : index == 1
                                              ? "Paris, France"
                                              : index == 2
                                              ? "London, United Kingdom"
                                              : "Rome, Italia",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontSize: 14,
                                            color: const Color(0xff757575),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xffFFD300),
                                              size: 15,
                                            ),
                                            Text(
                                              "  4.8  ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                fontSize: 14,
                                                color: Constants.primaryColor,
                                              ),
                                            ),
                                            Text(
                                              index == 0
                                                  ? "(4,981 reviews)"
                                                  : index == 1
                                                  ? "(4,981 reviews)"
                                                  : index == 2
                                                  ? "(3,672 reviews)"
                                                  : index == 3
                                                  ? "(4,441 reviews)"
                                                  : "(4,338 reviews)",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                fontSize: 14,
                                                color:
                                                const Color(0xff757575),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          index == 0
                                              ? "\$27"
                                              : index == 1
                                              ? "\$35"
                                              : index == 2
                                              ? "\$32"
                                              : index == 3
                                              ? "\$36"
                                              : "\$38",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontSize: 18,
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "/ night",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            fontSize: 10,
                                            color: const Color(0xff757575),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )
        )
    );
  }
}

Widget searchCard(String text, Color bgColor, VoidCallback onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      height: 38,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: Constants.primaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Text(
            text,
            style: Theme.of(Get.context!).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
