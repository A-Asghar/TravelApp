import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/screens/profile/EditProfile.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Constants.dart';
import '../../providers/UserProvider.dart';
import '../../widgets/customButton.dart';
import '../../widgets/poppinsText.dart';
import '../Home2.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

final UserProvider controller = Get.put(UserProvider());

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

                        // Name
                        GetBuilder<UserProvider>(
                          builder: (_) {
                            return poppinsText(
                              text: controller.user?.name ?? "Your Name",
                              size: 24.0,
                              fontBold: FontWeight.w700,
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        // Email
                        poppinsText(
                            text: controller.user?.email ??
                                "email@domain.com",
                            size: 14.0),
                        const Divider(color: Constants.secondaryColor),
                        const SizedBox(height: 20),

                        // Edit Profile
                        rowData(
                          'assets/images/profile.svg',
                          "Edit Profile",
                          () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EditProfile()));
                          },
                        ),
                        const SizedBox(height: 30),

                        // Payment
                        rowData(
                          'assets/images/Wallet.svg',
                          "Payment",
                          () {},
                        ),
                        const SizedBox(height: 30),

                        // Notification
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

                        // Security
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

                        // Help
                        rowData(
                          'assets/images/infoSquare.svg',
                          "Help",
                          () {},
                        ),
                        const SizedBox(height: 30),

                        // Logout
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
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      poppinsText(
                                          text: "Logout",
                                          size: 24.0,
                                          color: const Color(0xffF75555),
                                          fontBold: FontWeight.w500),
                                      const SizedBox(height: 20),
                                      const Divider(
                                          color: Constants.secondaryColor),
                                      const SizedBox(height: 20),
                                      poppinsText(
                                        text:
                                            "Are you sure you want to log out?",
                                        size: 20.0,
                                      ),
                                      const SizedBox(height: 30),
                                      CustomButton(
                                        text: "Yes, Logout",
                                        onTap: () async{
                                          Get.offAll(
                                            const Home2(),
                                            transition: Transition.rightToLeft,
                                          );
                                          Get.offAll(
                                            const Login(),
                                            transition: Transition.rightToLeft,
                                          );
                                          FirebaseAuth.instance.signOut();
                                              await GoogleSignIn(scopes: <String>["email"]).signOut();
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      CustomButton(
                                        text: "Cancel",
                                        bgColor: Constants.primaryColor
                                            .withOpacity(0.1),
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
          poppinsText(
              text: text,
              size: 18.0,
              color: text == "Logout" ? Colors.redAccent : Constants.secondaryColor,
              fontBold: FontWeight.w400),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
