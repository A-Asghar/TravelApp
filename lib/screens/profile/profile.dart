import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_agency/screens/agency_home.dart';
import 'package:travel_agency/screens/auth/Login.dart';
import 'package:travel_agency/screens/profile/EditProfile.dart';
import 'package:travel_agency/widgets/tealButton.dart';
import '../../Constants.dart';
import '../../providers/user_provider.dart';
import '../../widgets/poppinsText.dart';
import '../Security.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.all(20),
            child: poppinsText(
                text: 'Profile', size: 24.0, fontBold: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 20),
              Expanded(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const EditProfile(),
                                  transition: Transition.fade);
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      controller.user?.profilePhotoUrl ??
                                          'assets/images/user.png'),
                                  fit: BoxFit.fill,
                                ),
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
                            text: controller.user?.email ?? "email@domain.com",
                            size: 14.0),
                        const Divider(color: Constants.secondaryColor),
                        const SizedBox(height: 20),

                        // Edit Profile
                        rowData(
                          Icons.person,
                          "Edit Profile",
                          () {
                            Get.to(const EditProfile(),
                                transition: Transition.fade);
                          },
                        ),
                        const SizedBox(height: 30),

                        // Payment
                        rowData(
                          Icons.wallet,
                          "Payment",
                          () {},
                        ),
                        const SizedBox(height: 30),

                        // Notification
                        rowData(
                          Icons.notifications,
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
                          Icons.security,
                          "Security",
                          () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SecurityPolicyScreen()),
                            // );
                            print("error");

                          },
                        ),
                        const SizedBox(height: 30),

                        // Help
                        rowData(
                          Icons.help,
                          "Help",
                          () {},
                        ),
                        const SizedBox(height: 30),

                        // Logout
                        rowData(
                          Icons.logout_outlined,
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
                                      TealButton(
                                        text: "Yes, Logout",
                                        onPressed: () async {
                                          Get.offAll(
                                            const AgencyHome(),
                                            transition: Transition.rightToLeft,
                                          );
                                          Get.offAll(
                                            const Login(),
                                            transition: Transition.rightToLeft,
                                          );
                                          FirebaseAuth.instance.signOut();
                                          await GoogleSignIn().signOut();
                                        },
                                        bgColor: Colors.red.withOpacity(0.1),
                                        txtColor: Colors.white,
                                      ),
                                      const SizedBox(height: 15),
                                      TealButton(
                                        text: "Cancel",
                                        bgColor: Constants.primaryColor,
                                        txtColor: Colors.white,
                                        onPressed: () {
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

  Widget rowData(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          SizedBox(
            height: 28,
            width: 28,
            child: Icon(
              icon,
              color: text == 'Logout' ? Colors.red : Constants.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          poppinsText(
              text: text,
              size: 18.0,
              color: text == "Logout"
                  ? Colors.redAccent
                  : Constants.secondaryColor,
              fontBold: FontWeight.w400),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
