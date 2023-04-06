import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/providers/PackageHomeProvider.dart';
import 'package:fyp/repository/PackageRepository.dart';
import 'package:fyp/screens/BottomNavBar.dart';
import 'package:fyp/screens/Home2.dart';
import 'package:fyp/screens/auth/Login.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../../network/AuthNetwork.dart';
import '../../widgets/authErrorDialog.dart';
import '../../widgets/poppinsText.dart';
import '../../widgets/tealButton.dart';
import 'FillYourProfile.dart';

class SignUp extends StatefulWidget {
  SignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isChecked = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool validateEmail = true;
  bool validatePassword = true;
  bool validateConfirmPassword = true;
  bool isLoading = false;
  bool isLoadingGoogle = false;

  AuthNetwork authNetwork = AuthNetwork();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
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
                  prefix: Icons.email,
                  textFieldType: 'email',
                ),
                const SizedBox(height: 15),

                //Password
                CustomTextField(
                  hintText: "Password",
                  textFieldController: _password,
                  showError: validatePassword,
                  prefix: Icons.lock,
                  textFieldType: 'password',
                ),
                const SizedBox(height: 20),

                // Confirm Password
                CustomTextField(
                  hintText: "Confirm Password",
                  textFieldController: _confirmPassword,
                  showError: validatePassword,
                  prefix: Icons.lock,
                  textFieldType: 'password',
                ),
                const SizedBox(height: 20),

                // Remember Me
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: poppinsText(
                        text: 'Remember me',
                        color: Constants.secondaryColor,
                        size: 14.0,
                        fontBold: FontWeight.w500,
                      ),
                    ),
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      value: _isChecked,
                      onChanged: _handleRemeberme,
                      checkColor: Colors.white,
                      fillColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Constants.primaryColor;
                          }
                          return Constants.primaryColor;
                        },
                      ),
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
                        bgColor: Constants.primaryColor,
                        txtColor: Colors.white,
                        onPressed: () async {
                          if (validateTextFields()) {
                            setState(() => isLoading = true);
                            PackageRepository packageRepository =
                                PackageRepository();
                            if ((_password.text.isNotEmpty &&
                                    _confirmPassword.text.isNotEmpty) &&
                                (_password.text == _confirmPassword.text)) {
                              await AuthNetwork.createNewUser(
                                      email: _email.text,
                                      password: _password.text,
                                      role: "Traveler")
                                  .then((_) async {
                                context.read<PackageHomeProvider>().packages =
                                   await packageRepository.getAllPackages();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FillYourProfile(),
                                ));
                              }).catchError((e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: poppinsText(
                                        text: e.code,
                                        color: Colors.white,
                                        size: 16.0,
                                        fontBold: FontWeight.w400),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                setState(() => isLoading = false);
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: poppinsText(
                                      text: 'Passwords-do-not-match',
                                      color: Colors.white,
                                      size: 16.0,
                                      fontBold: FontWeight.w400),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }

                            setState(() => isLoading = false);

                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const FillYourProfile(),
                            // ));
                          }
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const FillYourProfile(),
                          // ));
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(width: 14),
                    poppinsText(
                      text: "or",
                      size: 18.0,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Container(
                        height: 1.5,
                        color: Colors.grey.shade400,
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

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
                                  text: 'Continue with Google',
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500)
                            ],
                          ),
                        ),
                        onTap: () async {
                          setState(() => isLoadingGoogle = true);

                          // var exists = await AuthNetwork.signInWithGoogle();

                          // exists
                          //     ? Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => const BottomNavBar(),
                          //       ))
                          //     : Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (context) => const FillYourProfile(),
                          //       ));
                          try {
                            final UserCredential? userCredential =
                                await authNetwork.signInWithGoogle();
                            if (userCredential != null) {
                              final User user = userCredential.user!;
                              final bool isNewUser = userCredential
                                      .additionalUserInfo?.isNewUser ??
                                  false;

                              if (isNewUser) {
                                Get.to(FillYourProfile(),
                                    transition: Transition.fade);
                              } else {
                                PackageRepository packageRepository =
                                    PackageRepository();
                                context.read<PackageHomeProvider>().packages =
                                    await packageRepository.getAllPackages();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Home2(),
                                  ),
                                );
                              }
                            }
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: poppinsText(
                                    text: e.message,
                                    color: Colors.white,
                                    size: 16.0,
                                    fontBold: FontWeight.w400),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          setState(() => isLoadingGoogle = false);
                        },
                      ),

                const SizedBox(height: 20),

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
                        text: "Sign In",
                        size: 14.0,
                        color: Constants.primaryColor,
                        fontBold: FontWeight.w500,
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

  void _handleRemeberme(bool? value) {
    print("Handle Rember Me");
    _isChecked = value!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _email.text);
        prefs.setString('password', _password.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _emailText = _prefs.getString("email") ?? "";
      var _passwordText = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      print(_remeberMe);
      print(_emailText);
      print(_passwordText);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _email.text = _emailText;
        _password.text = _passwordText;
      }
    } catch (e) {
      print(e);
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

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textFieldController;
  final IconData prefix;
  final String textFieldType;
  final bool showError;
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.textFieldController,
      required this.prefix,
      required this.textFieldType,
      required this.showError})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: SizedBox(
        height: 60,
        width: Get.width,
        child: TextFormField(
          focusNode: _focusNode,
          obscureText: widget.textFieldType == 'password' ? _isHidden : false,
          controller: widget.textFieldController,
          style: GoogleFonts.poppins(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            errorText: widget.showError ? null : 'This field can not be empty',
            contentPadding: const EdgeInsets.only(top: 15),
            fillColor: Colors.grey.withOpacity(0.05),
            filled: true,
            hintText: widget.hintText,
            suffixIcon: widget.textFieldType == 'password'
                ? InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHidden ? Icons.visibility_off : Icons.visibility,
                      color: _isFocused ? Constants.primaryColor : Colors.grey,
                    ),
                  )
                : SizedBox(),
            prefixIcon: Icon(
              widget.prefix,
              size: 20,
              color: _isFocused ? Constants.primaryColor : Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Constants.primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Constants.primaryColor,
              ),
            ),
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xff9E9E9E),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
