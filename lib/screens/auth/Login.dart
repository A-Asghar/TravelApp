import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/network/AuthNetwork.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/user_provider.dart';
import 'package:travel_agency/screens/auth/FillYourProfile.dart';
import 'package:travel_agency/screens/bottom_navbar.dart';
import 'package:travel_agency/screens/auth/ForgotPassword.dart';
import 'package:travel_agency/screens/auth/SignUp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_agency/widgets/authErrorDialog.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/tealButton.dart';
import 'package:travel_agency/screens/agency_home.dart';

import '../../providers/package_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isChecked = false;
  bool isLoading = false;
  bool isLoadingGoogle = false;
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool validateEmail = true;
  bool validatePassword = true;

  AuthNetwork authNetwork = AuthNetwork();

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _loadUserEmailPassword();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
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
                  prefix: Icons.email,
                  textFieldType: 'email',
                ),
                const SizedBox(height: 15),

                // Password
                CustomTextField(
                  hintText: "Password",
                  textFieldController: _password,
                  showError: validatePassword,
                  prefix: Icons.lock,
                  textFieldType: 'password',
                ),

                // Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                            fontBold: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Remember me
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

                // Signin Button
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Constants.primaryColor,
                        ),
                      )
                    : TealButton(
                        text: "Sign in",
                        bgColor: Constants.primaryColor,
                        txtColor: Colors.white,
                        onPressed: () async {
                          final UserProvider controller =
                              Get.put(UserProvider());
                          PackageNetwork packageNetwork = PackageNetwork();
                          try {
                            if (validateTextFields()) {
                              setState(() => isLoading = true);

                              await AuthNetwork.login(
                                  email: _email.text, password: _password.text);

                              print(controller.user);
                              if (controller.user!.role == 'Agency') {
                                context.read<PackageProvider>().agencyPackages =
                                    await packageNetwork.fetchAgencyPackages(
                                        FirebaseAuth.instance.currentUser!.uid);
                                context.read<PackageProvider>().allPackages =
                                    await packageNetwork.fetchPackages();
                                Get.to(BottomNavBar(),
                                    transition: Transition.fade);
                              } else {
                                FirebaseAuth.instance.signOut();
                                Get.to(Login(), transition: Transition.fade);
                              }

                              setState(() => isLoading = false);
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
                            setState(() => isLoading = false);
                          }
                        },
                      ),
                const SizedBox(height: 20),

                // or continue with
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
                const SizedBox(height: 25),

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
                                  text: 'Continue with Google',
                                  color: Constants.primaryColor,
                                  fontBold: FontWeight.w500)
                            ],
                          ),
                        ),
                        onTap: () async {
                          final UserProvider controller =
                              Get.put(UserProvider());
                          setState(() => isLoadingGoogle = true);

                          try {
                            final UserCredential? userCredential =
                                await authNetwork.signInWithGoogle();
                            if (userCredential != null) {
                              final User user = userCredential.user!;
                              final bool isNewUser = userCredential
                                      .additionalUserInfo?.isNewUser ??
                                  false;

                              if (isNewUser) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => FillYourProfile(),
                                  ),
                                );
                              } else {
                                PackageNetwork packageNetwork = PackageNetwork();
                                if (controller.user!.role == "Agency") {
                                  context
                                          .read<PackageProvider>()
                                          .agencyPackages =
                                      await packageNetwork.fetchAgencyPackages(
                                          FirebaseAuth
                                              .instance.currentUser!.uid);
                                  context.read<PackageProvider>().allPackages =
                                      await packageNetwork.fetchPackages();
                                  Get.to(BottomNavBar(),
                                      transition: Transition.fade);
                                } else if(controller.user!.role == "Traveler") {
                                  FirebaseAuth.instance.signOut();
                            Get.to(Login(), transition: Transition.fade);
                            setState(() => isLoadingGoogle = false);
                                }
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
                          text: "Sign Up",
                          size: 14.0,
                          color: Constants.primaryColor,
                          fontBold: FontWeight.w500),
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

        final UserProvider controller = Get.put(UserProvider());
        PackageNetwork packageNetwork = PackageNetwork();

        await AuthNetwork.login(email: _email.text, password: _password.text)
            .then((_) async {
          print(controller.user);
          if (controller.user!.role == 'Agency') {
            context.read<PackageProvider>().agencyPackages =
                await packageNetwork.fetchAgencyPackages(
                    FirebaseAuth.instance.currentUser!.uid);
            context.read<PackageProvider>().allPackages =
                await packageNetwork.fetchPackages();
            Get.to(BottomNavBar(), transition: Transition.fade);
          } else {
            FirebaseAuth.instance.signOut();
            Get.to(Login(), transition: Transition.fade);
            setState(() => isLoading = false);
          }
        }).catchError((e) {
          print(e.code);
          authErrorDialog(e.code, context);
        });
      }
    } catch (e) {
      print(e);
    }
  }
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
