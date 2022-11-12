import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/customTextField.dart';
import '../widgets/tealButton.dart';
import 'Home.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        title: Text(
          "User Details",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: searchCard(
                      //         "Mr.",
                      //         HexColor(AppTheme.primaryColorString!),
                      //             () {},
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Expanded(
                      //       child: searchCard(
                      //         "Mrs.",
                      //         Colors.transparent,
                      //             () {},
                      //       ),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     Expanded(
                      //       child: searchCard(
                      //         "Ms.",
                      //         Colors.transparent,
                      //             () {},
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                      CustomField(
                        hintText: "name",
                        textFieldController:
                        TextEditingController(text: "Daniel Austin"),
                        sufix: const SizedBox(),
                      ),
                      const SizedBox(height: 20),
                      CustomField(
                        hintText: "Address",
                        textFieldController:
                        TextEditingController(text: "3rd Oakwood Lane"),
                        sufix: const SizedBox(),
                      ),
                      const SizedBox(height: 20),
                      CustomField(
                        hintText: "Date Of Birth",
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
                      CustomField(
                        hintText: "Email",
                        textFieldController: TextEditingController(
                            text: "daniel_austin@yourdomain.com"),
                        sufix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                            'assets/images/email.svg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: "Phone Number",
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
                    ],
                  ),
                ],
              ),
            ),
            TealButton(
              text: "Continue",
              onPressed: () {
                // Get.to(
                //   const PaymentScreen(),
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
