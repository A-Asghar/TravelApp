import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/screens/BottomNavBar.dart';
import 'package:fyp/screens/auth/ForgotPassword.dart';
import 'package:fyp/screens/auth/SignUp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants.dart';
import '../../widgets/poppinsText.dart';
import '../../widgets/tealButton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRemember = false;
  bool isLoading = false;
  bool isLoadingGoogle = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool validateEmail = true;
  bool validatePassword = true;

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
                // Heading
                poppinsText(
                  text: "Login to your\nAccount",
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

                // Password
                CustomTextField(
                  hintText: "Password",
                  textFieldController: _password,
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

                // Remember me
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

                // Signin Button
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      )
                    : TealButton(
                        text: "Sign in",
                        onPressed: () async {
                          if (validateTextFields()) {
                            setState(() => isLoading = true);

                            // await Network.login(
                            //         email: _email.text,
                            //         password: _password.text)
                            //     .catchError((e) {
                            //   print(e.code);
                            //   authErrorDialog(e.code, context);
                            //   setState(() => isLoading = false);
                            // }).then(() {
                            //   Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const Home2(),
                            //   ));
                            // });

                            setState(() => isLoading = false);

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const BottomNavBar(),
                            ));
                          }
                        },
                      ),
                const SizedBox(height: 25),

                // Forgot password
                InkWell(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPassword()));
                  },
                  child: Center(
                    child: poppinsText(
                      text: "Forgot password?",
                      size: 16.0,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // or continue with
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.5,
                        color: const Color(0xffEEEEEE),
                      ),
                    ),
                    const SizedBox(width: 14),
                    poppinsText(
                      text: "or continue with",
                      size: 18.0,
                      color: const Color(0xff616161),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Container(
                        height: 1.5,
                        color: const Color(0xffEEEEEE),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Signin with google
                isLoadingGoogle
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      )
                    : InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Constants.secondaryColor.withOpacity(0.1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                  image: AssetImage('assets/images/s2.png'),
                                  height: 20),
                              const SizedBox(
                                width: 10,
                              ),
                              poppinsText(
                                  text: 'Sign in with Google',
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500)
                            ],
                          ),
                        ),
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BottomNavBar(),
                          ));

                          // setState(() => isLoadingGoogle = true);
                          //
                          // var exists = await Network.signInWithGoogle();
                          //
                          // exists
                          //     ? Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => const Home2(),
                          //       ))
                          //     : Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => const FillYourProfile(),
                          //       ));
                          // setState(() => isLoadingGoogle = false);
                        },
                      ),

                const SizedBox(height: 20),

                // Don't have an account
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      poppinsText(
                        text: "Don’t have an account?  ",
                        size: 14.0,
                        color: const Color(0xff9E9E9E),
                      ),
                      poppinsText(
                        text: "Sign up",
                        size: 14.0,
                        color: Constants.primaryColor,
                      ),
                    ],
                  ),
                ),
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
    if (validateEmail && validatePassword) {
      return true;
    } else {
      return false;
    }
  }
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
