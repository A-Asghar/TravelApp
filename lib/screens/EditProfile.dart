import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/customField.dart';
import '../widgets/customTextField.dart';
import '../widgets/poppinsText.dart';
import '../widgets/tealButton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

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
            color: Theme.of(context).textTheme.bodyText1!.color,
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
                        textFieldController:
                            TextEditingController(text: "Ali Asghar"),
                        sufix: const SizedBox(),
                      ),
                      const SizedBox(height: 15),

                      // Address
                      CustomField(
                        hintText: "address",
                        textFieldController:
                            TextEditingController(text: "315 Oakwood Lane"),
                        sufix: const SizedBox(),
                      ),
                      const SizedBox(height: 15),

                      // Date of birth
                      CustomField(
                        hintText: "date of birth",
                        textFieldController:
                            TextEditingController(text: "12/27/1995"),
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
                        textFieldController: TextEditingController(
                            text: "ali_asghar@yourdomain.com"),
                        sufix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/p4.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Phone Number
                      CustomTextField(
                        hintText: "name",
                        textFieldController:
                            TextEditingController(text: "+1 111 467 378 399"),
                        sufix: const SizedBox(),
                        prefix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/p2.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Gender
                      CustomField(
                        hintText: "gender",
                        textFieldController:
                            TextEditingController(text: "Male"),
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
            TealButton(
              text: "Update",
              onPressed: () {
                // Get.offAll(
                //   const TabScreen(),
                //   transition: Transition.rightToLeft,
                // );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
