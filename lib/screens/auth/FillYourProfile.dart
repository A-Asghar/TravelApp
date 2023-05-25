import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/Constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_agency/models/Users.dart';
import 'package:travel_agency/network/auth_network.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/providers/user_provider.dart';
import 'package:travel_agency/screens/bottom_navbar.dart';
import 'package:travel_agency/widgets/imageOptions.dart';
import 'package:travel_agency/widgets/tealButton.dart';

import '../../widgets/poppinsText.dart';

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
  bool validateEmail = true;
  bool validatePhoneNumber = true;
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

  Future<String> uploadFile(File image) async {
    String downloadURL;
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("post_$postId.jpg");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider controller = Get.put(UserProvider());
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              SystemNavigator.pop();
            },
            child: const Icon(Icons.arrow_back_ios,
                size: 25, color: Constants.secondaryColor),
          ),
          centerTitle: true,
          title: poppinsText(
              text: "Fill Your Profile", size: 24.0, fontBold: FontWeight.w500),
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
                            onTap: () => _showSelectPhotoOptions(context),
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: _image == null ||
                                          !File(_image!.path).existsSync()
                                      ? AssetImage('assets/images/user.png')
                                      : FileImage(File(_image!.path))
                                          as ImageProvider<Object>,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Name
                        CustomTextField(
                            hintText: "agency name",
                            textFieldController: _name,
                            showError: validateName,
                            sufix: const SizedBox(),
                            prefix: Icons.person),
                        const SizedBox(height: 20),

                        // Address
                        CustomTextField(
                            hintText: "address",
                            textFieldController: _address,
                            showError: validateAddress,
                            sufix: const SizedBox(),
                            prefix: Icons.location_on),
                        const SizedBox(height: 20),

                        // Date of birth
                        // CustomTextField(
                        //     readOnly: true,
                        //     onTap: () => _selectDate(context),
                        //     keyboardType: TextInputType.datetime,
                        //     hintText: "date of birth",
                        //     showError: validateDateOfBirth,
                        //     textFieldController: _dateOfBirth,
                        //     sufix: const SizedBox(),
                        //     prefix: Icons.calendar_month_rounded),

                        // const SizedBox(height: 20),

                        // Phone number
                        CustomTextField(
                            showError: validatePhoneNumber,
                            keyboardType: TextInputType.phone,
                            hintText: "phone",
                            textFieldController: _phoneNumber,
                            sufix: const SizedBox(),
                            prefix: Icons.phone),
                        const SizedBox(height: 20),

                        // Gender
                        // GenderDropdown(genderController: _gender),
                        // const SizedBox(height: 20),
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
                        bgColor: Constants.primaryColor,
                        txtColor: Colors.white,
                        onPressed: () async {
                          if (validateTextFields()) {
                            setState(() => isLoading = true);

                            String profilePhotoUrl = '';

                            if (_image != null) {
                              profilePhotoUrl = await uploadFile(_image!);
                            } else {
                              profilePhotoUrl = 'assets/images/user.png';
                            }

                            await AuthNetwork.createUserProfile(
                              signedInUser: FirebaseAuth.instance.currentUser!,
                              user: Users(
                                email:
                                    FirebaseAuth.instance.currentUser!.email!,
                                role: controller.user!.role,
                                name: _name.text,
                                address: _address.text,
                                dateOfBirth: _dateOfBirth.text,
                                phoneNumber: _phoneNumber.text,
                                gender: _gender.text,
                                profilePhotoUrl: profilePhotoUrl.isEmpty
                                    ? ''
                                    : profilePhotoUrl,
                                searchedCities: [],
                              ),
                            ).then((_) async {
                              PackageNetwork packageNetwork = PackageNetwork();
                              context.read<PackageProvider>().allPackages =
                                  await packageNetwork.fetchPackages();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                              ));
                              setState(() => isLoading = false);
                            });
                          }

                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const BottomNavBar(),
                          // ));
                        },
                      ),
              ),
            ],
          ),
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
              colorScheme: ColorScheme.light(
                primary: Constants.primaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Constants.secondaryColor, // body text color
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
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2024));

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
    // if (_dateOfBirth.text.isEmpty) {
    //   setState(() => validateDateOfBirth = false);
    // } else {
    //   setState(() => validateDateOfBirth = true);
    // }

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
    // if (_gender.text.isEmpty) {
    //   setState(() => validateGender = false);
    // } else {
    //   setState(() => validateGender = true);
    // }

    if ( validatePhoneNumber &&
        validateEmail &&
        validateAddress &&
        validateName)
      return true;
    else
      return false;
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textFieldController;
  final IconData prefix;
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
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

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
            prefixIcon: Icon(
              widget.prefix,
              color: _isFocused ? Constants.primaryColor : Colors.grey,
            ),
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
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key, required this.genderController});
  final TextEditingController genderController;

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String? _selectedGender;
  final FocusNode _genderFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedGender = 'Select your gender';
    _genderFocusNode.addListener(() {
      setState(() {
        _isFocused = _genderFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _genderFocusNode.dispose();
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
      child: Container(
        padding: EdgeInsets.only(left: 10),
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(Icons.wc,
                color: _isFocused ? Constants.primaryColor : Colors.grey),
            Expanded(
              child: DropdownButton2(
                underline: Container(),
                focusNode: _genderFocusNode,
                hint: poppinsText(text: _selectedGender!),
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.man,
                            color: _isFocused
                                ? Constants.primaryColor
                                : Colors.grey),
                        SizedBox(width: 16.0),
                        poppinsText(text: 'Male')
                      ],
                    ),
                    value: 'Male',
                  ),
                  DropdownMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.woman,
                            color: _isFocused
                                ? Constants.primaryColor
                                : Colors.grey),
                        SizedBox(width: 16.0),
                        poppinsText(text: 'Female')
                      ],
                    ),
                    value: 'Female',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                    widget.genderController.text = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
