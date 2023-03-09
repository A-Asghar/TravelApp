import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/models/Users.dart';
import 'package:fyp/network/AuthNetwork.dart';
import 'package:fyp/widgets/successSnackBar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../providers/UserProvider.dart';
import '../../widgets/customField.dart';
import '../../widgets/poppinsText.dart';
import '../../widgets/tealButton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final UserProvider controller = Get.put(UserProvider());

TextEditingController name =
    TextEditingController(text: controller.user?.name ?? '');
TextEditingController email =
    TextEditingController(text: controller.user?.email ?? '');
TextEditingController phoneNumber =
    TextEditingController(text: controller.user?.phoneNumber ?? '');
TextEditingController profilePhotoUrl =
    TextEditingController(text: controller.user?.profilePhotoUrl ?? '');
TextEditingController dateOfBirth =
    TextEditingController(text: controller.user?.dateOfBirth ?? '');
TextEditingController gender =
    TextEditingController(text: controller.user?.gender ?? '');
TextEditingController address =
    TextEditingController(text: controller.user?.address ?? '');

bool isLoading = false;

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1?.color,
            size: 25,
          ),
        ),
        title: poppinsText(
          text: "Edit Profile",
          size: 24.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Name
                      CustomField(
                        hintText: "name",
                        textFieldController: name,
                        // TextEditingController(text: "Ali Asghar"),
                        sufix: const SizedBox(),
                      ),
                      const SizedBox(height: 15),

                      // Address
                      CustomField(
                        hintText: "address",
                        textFieldController: address,
                        // TextEditingController(text: "315 Oakwood Lane"),
                        sufix: const SizedBox(),
                      ),
                      const SizedBox(height: 15),

                      // Date of birth
                      CustomField(
                        hintText: "date of birth",
                        textFieldController: dateOfBirth,
                        // TextEditingController(text: "12/27/1995"),
                        sufix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/Calendar.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email
                      CustomField(
                        hintText: "email",
                        textFieldController: email,
                        // TextEditingController(text: "ali_asghar@yourdomain.com"),
                        sufix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/p4.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Phone Number
                      CustomField(
                        hintText: "phoneNumber",
                        textFieldController: phoneNumber,
                        // TextEditingController(text: "ali_asghar@yourdomain.com"),
                        sufix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/phone.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Gender
                      CustomField(
                        hintText: "gender",
                        textFieldController: gender,
                        // TextEditingController(text: "Male"),
                        sufix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/arrow.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.teal)
                  : TealButton(
                      text: "Update",
                      onPressed: () async {
                        setState(() => isLoading = true);

                        Users u = Users(
                          name: name.text,
                          email: email.text,
                          phoneNumber: phoneNumber.text,
                          profilePhotoUrl: profilePhotoUrl.text,
                          dateOfBirth: dateOfBirth.text,
                          gender: gender.text,
                          address: address.text,
                          searchedCities: [],
                        );
                        await AuthNetwork.createUserProfile(
                                signedInUser:
                                    FirebaseAuth.instance.currentUser!,
                                user: u)
                            .then((_) {
                          Navigator.of(context).pop();
                          successSnackBar(context,
                              'Your details have been updated successfully !');
                        });
                        setState(() => isLoading = false);
                        // Get.offAll(
                        //   const TabScreen(),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
