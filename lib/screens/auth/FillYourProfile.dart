import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/Constants.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Users.dart';
import '../../network.dart';

import '../../widgets/imageOptions.dart';
import '../../widgets/poppinsText.dart';
import '../../widgets/tealButton.dart';
import '../BottomNavBar.dart';
import '../Home2.dart';

class FillYourProfile extends StatefulWidget {
  const FillYourProfile({Key? key}) : super(key: key);

  @override
  State<FillYourProfile> createState() => _FillYourProfileState();
}

class _FillYourProfileState extends State<FillYourProfile> {
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _dateOfBirth = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _gender = TextEditingController();
  bool validateName = true;
  bool validateAddress = true;
  bool validateDateOfBirth = true;
  bool validateEmail = true;
  bool validatePhoneNumber = true;
  bool validateGender = true;
  bool isLoading = false;

  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        // ),
        centerTitle: true,
        title: poppinsText(
          text:"Fill Your Profile",
          size: 24.0
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

                      // Profile Picture
                      Center(
                        child: InkWell(
                          onTap: ()=>_showSelectPhotoOptions(context),
                          child: Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    _image?.path ?? 'assets/images/user.png'
                                  // _image == null ? 'assets/images/user.png' : _image!.path,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name
                      CustomTextField(
                        hintText: "name",
                        textFieldController: _name,
                        showError: validateName,
                        sufix: const SizedBox(),
                        prefix: const SizedBox(),
                      ),
                      const SizedBox(height: 15),

                      // Address
                      CustomTextField(
                        hintText: "address",
                        textFieldController: _address,
                        showError: validateAddress,
                        sufix: const SizedBox(),
                        prefix: const SizedBox(),
                      ),
                      const SizedBox(height: 15),

                      // Date of birth
                      CustomTextField(
                          readOnly: true,
                          onTap: ()=>_selectDate(context),
                          keyboardType: TextInputType.datetime,
                          hintText: "date of birth",
                          showError: validateDateOfBirth,
                          textFieldController: _dateOfBirth,
                          sufix: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              'assets/images/Calendar.svg',
                              color: Constants.secondaryColor,
                            ),
                          ),
                          prefix: const SizedBox(),
                        ),

                      const SizedBox(height: 20),

                      // Phone number
                      CustomTextField(
                        showError: validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                        hintText: "phone",
                        textFieldController: _phoneNumber,
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
                      CustomTextField(
                        showError: validateGender,
                        hintText: "gender",
                        textFieldController: _gender,
                        sufix: const SizedBox(),
                        prefix: const SizedBox(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  : TealButton(
                      text: "Continue",
                      onPressed: () async {
                        // if (validateTextFields()) {
                        //   setState(() => isLoading = true);
                        //   await Network.createUserProfile(
                        //     signedInUser: FirebaseAuth.instance.currentUser!,
                        //     user: Users(
                        //         email:
                        //             FirebaseAuth.instance.currentUser!.email!,
                        //         name: _name.text,
                        //         address: _address.text,
                        //         dateOfBirth: _dateOfBirth.text,
                        //         phoneNumber: _phoneNumber.text,
                        //         gender: _gender.text,
                        //         profilePhotoUrl: _image?.path ?? ''),
                        //   ).then((_) {
                        //     setState(() => isLoading = false);
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => const BottomNavBar(),
                        //     ));
                        //   });
                        // }

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BottomNavBar(),
                        ));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = DateTime.now();
    selectedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              colorScheme: const ColorScheme.light(
                primary: Constants.primaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Constants.primaryColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950,1),
        lastDate: DateTime(2023));

    if (selectedDate != null) {
      setState(() {
        _dateOfBirth.text = Constants.convertDate(selectedDate);
      });
    }

  }

  validateTextFields() {
    // Name
    if (_name.text.isEmpty) {
      setState(() => validateName = false);
    } else {
      setState(() => validateName = true);
    }

    // Address
    if (_address.text.isEmpty) {
      setState(() => validateAddress = false);
    } else {
      setState(() => validateAddress = true);
    }

    // Date of birth
    if (_dateOfBirth.text.isEmpty) {
      setState(() => validateDateOfBirth = false);
    } else {
      setState(() => validateDateOfBirth = true);
    }

    // // Email
    // if(_email.text.isEmpty){
    //   setState(() => validateEmail= false);
    // }else{
    //   setState(() => validateEmail = true);
    // }

    // Phone Number
    if (_phoneNumber.text.length < 11) {
      setState(() => validatePhoneNumber = false);
    } else {
      setState(() => validatePhoneNumber = true);
    }

    // Gender
    if (_gender.text.isEmpty) {
      setState(() => validateGender = false);
    } else {
      setState(() => validateGender = true);
    }

    if (validateGender && validatePhoneNumber && validateEmail
        && validateDateOfBirth && validateDateOfBirth && validateAddress
        && validateName)
      return true;
    else
      return false;
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textFieldController;
  final Widget prefix;
  final Widget sufix;
  final bool hideText;
  final bool showError;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.textFieldController,
      required this.prefix,
      required this.sufix,
      this.hideText = false,
      required this.showError,
      this.keyboardType = TextInputType.text,
      this.onTap,
      this.readOnly = false})
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
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        obscureText: widget.hideText,
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
}
