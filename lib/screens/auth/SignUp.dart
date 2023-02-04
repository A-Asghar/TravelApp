import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants.dart';
import '../../network/AuthNetwork.dart';
import '../../widgets/authErrorDialog.dart';
import '../../widgets/poppinsText.dart';
import '../../widgets/tealButton.dart';
import 'FillYourProfile.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isRemember = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool validateEmail = true;
  bool validatePassword = true;
  bool validateConfirmPassword = true;
  bool isLoading = false;
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
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                poppinsText(
                  text: "Create your\nAccount",
                  size: 48.0,
                  fontBold: FontWeight.w700,
                ),
                const SizedBox(height: 20),

                // Email
                CustomTextField(
                  hintText: "Email",
                  textFieldController: _email,
                  showError: validateEmail,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      'assets/images/email.svg',
                    ),
                  ),
                  sufix: const SizedBox(),
                ),
                const SizedBox(height: 15),

                //Password
                CustomTextField(
                  hintText: "Password",
                  textFieldController: _password,
                  hideText: true,
                  showError: validatePassword,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      'assets/images/lock.svg',
                    ),
                  ),
                  sufix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      'assets/images/eye.svg',
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password
                CustomTextField(
                  hintText: "Confirm Password",
                  textFieldController: _confirmPassword,
                  hideText: true,
                  showError: validateConfirmPassword,
                  prefix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      'assets/images/lock.svg',
                    ),
                  ),
                  sufix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset(
                      'assets/images/eye.svg',
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Remember Me
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: isRemember == true
                              ? Constants.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: Constants.primaryColor,
                          ),
                        ),
                        child: Icon(
                          Icons.check,
                          color: isRemember ? Colors.white : Colors.transparent,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    poppinsText(
                      text: "Remember me",
                      size: 14.0,
                      fontBold: FontWeight.w700,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Signup Button
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      )
                    : TealButton(
                        text: "Sign up",
                        onPressed: () async {
                          if (validateTextFields()) {
                            setState(() => isLoading = true);

                            if ((_password.text.isNotEmpty &&
                                    _confirmPassword.text.isNotEmpty) &&
                                (_password.text == _confirmPassword.text)) {
                              await AuthNetwork.createNewUser(
                                      email: _email.text,
                                      password: _password.text)
                                  .then((_){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FillYourProfile(),
                                ));
                              }).catchError((e) {
                                authErrorDialog(e.code, context);
                                setState(() => isLoading = false);
                              });
                            } else {
                              authErrorDialog("passwords-not-match", context);
                            }

                            setState(() => isLoading = false);

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const FillYourProfile(),
                            ));
                          }
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const FillYourProfile(),
                          // ));
                        },
                      ),
                const SizedBox(height: 40),

                // Already have an account?
                InkWell(
                  onTap: () {
                    // Get.to(
                    //   const LoginScreen(),
                    //   transition: Transition.rightToLeft,
                    // );
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      poppinsText(
                        text: "Already have an account?  ",
                        size: 14.0,
                        color: const Color(0xff9E9E9E),
                      ),
                      poppinsText(
                        text: "Sign in",
                        size: 14.0,
                        color: Constants.primaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  validateTextFields() {
    if (_email.text.isEmpty) {
      setState(() => validateEmail = false);
    } else {
      setState(() => validateEmail = true);
    }
    if (_password.text.isEmpty) {
      setState(() => validatePassword = false);
    } else {
      setState(() => validatePassword = true);
    }
    if (_confirmPassword.text.isEmpty) {
      setState(() => validateConfirmPassword = false);
    } else {
      setState(() => validateConfirmPassword = true);
    }
    if (validateEmail && validatePassword && validateConfirmPassword)
      return true;
    else
      return false;
  }
}

Widget socialButton(String image) {
  return Container(
    height: 60,
    width: 88,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xffEEEEEE),
      ),
    ),
    child: Center(
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
          ),
        ),
      ),
    ),
  );
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textFieldController;
  final Widget prefix;
  final Widget sufix;
  final bool hideText;
  final bool showError;
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.textFieldController,
      required this.prefix,
      required this.sufix,
      this.hideText = false,
      required this.showError})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: Get.width,
      child: TextFormField(
        obscureText: widget.hideText,
        controller: widget.textFieldController,
        style: GoogleFonts.poppins(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          errorText: widget.showError ? null : 'This field can not be empty',
          contentPadding: const EdgeInsets.only(top: 15),
          fillColor: const Color(0xffFAFAFA),
          filled: true,
          hintText: widget.hintText,
          suffixIcon: widget.sufix,
          prefixIcon: widget.prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xff9E9E9E),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  validateTextField(text) {
    if (text.length > 0) {
      return null;
    } else {
      return 'This field can not be empty';
    }
  }
}
