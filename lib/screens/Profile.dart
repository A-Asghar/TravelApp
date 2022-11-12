import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/screens/EditProfile.dart';
import 'package:get/get.dart';

import '../Constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 20),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    "Profile",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              ),
              Expanded(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/user.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Daniel Austin",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "daniel_austin@yourdomain.com",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const Divider(color: Color(0xffEEEEEE)),
                        const SizedBox(height: 20),
                        rowData(
                          'assets/images/profile.svg',
                          "Edit Profile",
                              () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditProfile()));
                          },
                        ),
                        const SizedBox(height: 30),
                        rowData(
                          'assets/images/Wallet.svg',
                          "Payment",
                              () {},
                        ),
                        const SizedBox(height: 30),
                        rowData(
                          'assets/images/Notification.svg',
                          "Notifications",
                              () {
                            // Get.to(
                            //   const NotificationScreen(),
                            //   transition: Transition.rightToLeft,
                            // );
                          },
                        ),
                        const SizedBox(height: 30),
                        rowData(
                          'assets/images/sheildDone.svg',
                          "Security",
                              () {
                            // Get.to(
                            //   const SecurityScreen(),
                            //   transition: Transition.rightToLeft,
                            // );
                          },
                        ),
                        const SizedBox(height: 30),
                        rowData(
                          'assets/images/infoSquare.svg',
                          "Help",
                              () {},
                        ),
                        const SizedBox(height: 30),

                        rowData(
                          'assets/images/Logout.svg',
                          "Logout",
                              () {
                            Get.bottomSheet(
                              Container(
                                height: 300,
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        "Logout",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                          fontSize: 24,
                                          color: const Color(0xffF75555),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(color: Color(0xffEEEEEE)),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Are you sure you want to log out?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      CustomButton(
                                        text: "Yes, Logout",
                                        onTap: () {
                                          // Get.offAll(
                                          //   const WelcomeScreen(),
                                          //   transition: Transition.rightToLeft,
                                          // );
                                          // Get.offAll(
                                          //   const LoginScreen(),
                                          //   transition: Transition.rightToLeft,
                                          // );
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      CustomButton(
                                        text: "Cancel",
                                        bgColor: Constants.primaryColor.withOpacity(0.1),
                                        textColor: Constants.primaryColor,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rowData(String image, String text, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          SizedBox(
            height: 28,
            width: 28,
            child: SvgPicture.asset(
              image,
              color: text == "Logout"
                  ? const Color(0xffF75555)
                  : Theme.of(context).textTheme.bodyText1!.color,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 18,
              color: text == "Logout"
                  ? const Color(0xffF75555)
                  : Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          const Expanded(child: SizedBox()),
          // text == "Dark Theme"
          //     ? SizedBox(
          //   height: 5,
          //   child: CupertinoSwitch(
          //     onChanged: (bool value) {
          //       setState(() {
          //         profileController.isDark.value = value;
          //
          //         if (value == true) {
          //           changeColor(dark);
          //         } else {
          //           changeColor(light);
          //         }
          //       });
          //     },
          //     value: profileController.isDark.value,
          //   ),
          // )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}
class CustomButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final VoidCallback onTap;
  const CustomButton(
      {Key? key,
        required this.text,
        this.bgColor,
        this.textColor,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          // width: Get.width,
          decoration: BoxDecoration(
            color: bgColor ?? Constants.primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
