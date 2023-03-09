import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:fyp/network/AuthNetwork.dart';
import 'package:fyp/screens/auth/SignUp.dart';
import 'package:fyp/widgets/poppinsText.dart';
import 'package:fyp/widgets/tealButton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();
  AuthNetwork network = AuthNetwork();
  bool isLoading = false;
  bool validateEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,
              size: 25, color: Constants.secondaryColor),
        ),
      ),
      body: // Email
          Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            poppinsText(
              text: 'Forgot your \nPassword?',
              size: 48.0,
              fontBold: FontWeight.bold,
              color: Constants.secondaryColor,
            ),
            const SizedBox(height: 100),
            Center(
              child: CustomTextField(
                hintText: "Email",
                textFieldController: _email,
                showError: validateEmail,
                prefix: Icons.email,
                textFieldType: 'email',
              ),
            ),
            TealButton(
              text: 'Send reset link',
              onPressed: () async {
                if (_email.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Email field can\'t be empty'),
                  ));
                } else {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _email.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Password reset email sent to: ${_email.text} \nIf you didn't receive the email, be sure to check your Spam folder"),
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
    );
  }

  validateTextFields() {
    if (_email.text.isEmpty) {
      setState(() => validateEmail = false);
    } else {
      setState(() => validateEmail = true);
    }
  }
}
