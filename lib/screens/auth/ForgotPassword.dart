import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';

import '../../Constants.dart';
import '../../widgets/customTextField.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: poppinsText(text: 'Forgot Password'),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: "Email",
              textFieldController: email,
              prefix: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  'assets/images/email.svg',
                ),
              ),
              sufix: const SizedBox(),
            ),
            TealButton(
              text: 'Send reset link',
              onPressed: () async {
                if (email.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Email field can\'t be empty'),
                  ));
                } else {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Password reset email sent to: ${email.text} \nIf you didn't receive the email, be sure to check your Spam folder"),
                    ));
                    Navigator.pop(context);
                  }).catchError((err) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(Constants.authErrors[err.code]!),
                    ));
                  });
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
