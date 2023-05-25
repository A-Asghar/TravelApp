import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/providers/user_provider.dart';
import 'package:travel_agency/screens/agency_home.dart';
import 'package:travel_agency/screens/auth/Login.dart';
import 'package:travel_agency/screens/profile/EditProfile.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/tealButton.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final UserProvider controller = Get.put(UserProvider());
  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: poppinsText(
                text: controller.user!.name,
                size: 16.0,
                color: Colors.white,
                fontBold: FontWeight.w400),
            accountEmail: poppinsText(
                text: controller.user!.email,
                size: 16.0,
                color: Colors.white,
                fontBold: FontWeight.w400),
            currentAccountPicture:
                controller.user!.profilePhotoUrl == "assets/images/user.png" ||
                        controller.user!.profilePhotoUrl.isEmpty
                    ? CircleAvatar(
                        backgroundColor: Constants.primaryColor,
                        child: poppinsText(
                            text: controller.user!.name.substring(0, 1),
                            size: 20.0,
                            color: Colors.white,
                            fontBold: FontWeight.w500))
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                          controller.user!.profilePhotoUrl,
                        ),
                      ),
            currentAccountPictureSize: Size.square(60.0),
            arrowColor: Colors.transparent,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mountains.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            onDetailsPressed: () {
              Get.to(EditProfile(), transition: Transition.fade);
            },
          ),
          ListTile(
              leading:
                  Icon(Icons.person_2_sharp, color: Constants.primaryColor),
              title: poppinsText(text: 'Edit Profile', size: 20.0),
              onTap: () {
                Get.to(EditProfile(), transition: Transition.fade);
              }),
          ListTile(
            leading: Icon(Icons.wallet, color: Constants.primaryColor),
            title: poppinsText(text: 'Payment', size: 20.0),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Constants.primaryColor),
            title: poppinsText(text: 'Notifications', size: 20.0),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.security, color: Constants.primaryColor),
            title: poppinsText(text: 'Security', size: 20.0),
          ),
          ListTile(
            leading: Icon(Icons.help, color: Constants.primaryColor),
            title: poppinsText(text: 'Help', size: 20.0),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: poppinsText(text: 'Logout', size: 20.0, color: Colors.red),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onTap: () {
              Get.bottomSheet(
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        poppinsText(
                            text: "Logout",
                            size: 24.0,
                            color: const Color(0xffF75555),
                            fontBold: FontWeight.w500),
                        const SizedBox(height: 20),
                        const Divider(color: Constants.secondaryColor),
                        poppinsText(
                          text: "Are you sure you want to log out?",
                          size: 20.0,
                        ),
                        const SizedBox(height: 20),
                        isLoggingOut
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              )
                            : TealButton(
                                text: "Yes, Logout",
                                onPressed: () async {
                                  setState(() => isLoggingOut = true);
                                  SharedPreferences.getInstance().then(
                                    (prefs) {
                                      prefs.setBool("remember_me", false);
                                    },
                                  );
                                  Get.offAll(
                                    const AgencyHome(),
                                    transition: Transition.rightToLeft,
                                  );
                                  Get.offAll(
                                    const Login(),
                                    transition: Transition.rightToLeft,
                                  );
                                  setState(() => isLoggingOut = false);
                                  await FirebaseAuth.instance.signOut();
                                  // await GoogleSignIn().signOut();
                                },
                                bgColor: Colors.red.withOpacity(0.3),
                                txtColor: Colors.red,
                              ),
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
        ],
      ),
    );
  }
}
