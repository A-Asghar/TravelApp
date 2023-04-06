import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/screens/package/SearchDestination.dart';
import 'package:travel_agency/screens/package/itinerary_screen.dart';
import 'package:travel_agency/screens/package/package_preview_screen.dart';
import 'package:travel_agency/widgets/pop_button.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/tealButton.dart';

PackageNetwork pak = PackageNetwork();

class AddPackageForm extends StatefulWidget {
  @override
  _AddPackageFormState createState() => _AddPackageFormState();
}

class _AddPackageFormState extends State<AddPackageForm> {
  final _formKey = GlobalKey<FormState>();
  final _packageNameController = TextEditingController();
  final _packagePriceController = TextEditingController();
  final _packageDescriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _numOfDaysController = TextEditingController();
  final _imgUrlsController = TextEditingController();
  final _adultsController = TextEditingController();
  final _hotelPropertyIdController = TextEditingController();
  late DateTime _selectedDate;

  List<String> _imgUrls = <String>[];

  Future<void> _loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pick images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
      _error = error;
    });

    if (_images.isNotEmpty) {
      await _uploadImagesToFirebase();
    }
  }

  Future<void> _uploadImagesToFirebase() async {
    for (var i = 0; i < _images.length; i++) {
      final byteData = await _images[i].getByteData();
      final imageData = byteData.buffer.asUint8List();

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('packages/${DateTime.now().toString()}');
      final uploadTask = storageRef.putData(imageData);

      await uploadTask.whenComplete(() => null);

      final url = await storageRef.getDownloadURL();
      setState(() {
        _imgUrls.add(url);
      });
    }
  }

  bool isLoading = false;

  List<Asset> _images = <Asset>[];
  String _error = 'No Error Dectected';
  @override
  Widget build(BuildContext context) {
    String to = context.watch<PackageProvider>().to.city == ''
        ? 'Select a destination'
        : context.watch<PackageProvider>().to.city;
    var packageProvider = context.watch<PackageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: poppinsText(
            text: 'Add Package',
            color: Colors.white,
            size: 24.0,
            fontBold: FontWeight.w600),
        centerTitle: true,
        leading: PopButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.86,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          PackageField(
                            controller: _packageNameController,
                            labelText: 'Package Name',
                            hintText: 'Enter the package name',
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter the package name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          PackageField(
                            controller: _packagePriceController,
                            keyboardType: TextInputType.number,
                            labelText: 'Package Price',
                            hintText: 'Enter the package price',
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter the package price';
                              }
                              if (double.tryParse(value!) == null) {
                                return 'Please enter a valid price';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          PackageField(
                            controller: _packageDescriptionController,
                            labelText: 'Package Description',
                            hintText: 'Enter the package description',
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter the package description';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 365)),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData(
                                            primarySwatch: Colors.teal,
                                            accentColor: Colors.teal,
                                            colorScheme: ColorScheme.light(
                                                primary: Colors.teal),
                                          ),
                                          child: child ?? Container(),
                                        );
                                      },
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          _selectedDate = selectedDate;
                                          _startDateController.text =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(selectedDate);
                                        });
                                      }
                                    });
                                  },
                                  child: AbsorbPointer(
                                    child: PackageField(
                                      controller: _startDateController,
                                      labelText: 'Start Date',
                                      hintText: 'Select a start date',
                                      keyboardType: TextInputType.datetime,
                                      validator: (value) {
                                        if (value?.isEmpty ?? false) {
                                          return 'Please select a start date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          PackageField(
                            controller: _numOfDaysController,
                            keyboardType: TextInputType.number,
                            labelText: 'Number of Days',
                            hintText: 'Enter the number of days',
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter the number of days';
                              }
                              if (int.tryParse(value!) == null) {
                                return 'Please enter a valid number of days';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TealButton(
                            onPressed: _loadAssets,
                            text: 'Add images',
                            bgColor: Constants.primaryColor,
                            txtColor: Colors.white,
                          ),
                          SizedBox(height: 16.0),
                          PackageField(
                            controller: _adultsController,
                            keyboardType: TextInputType.number,
                            labelText: 'Number of Adults',
                            hintText: 'Enter the number of adults',
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter the number of adults';
                              }
                              if (int.tryParse(value!) == null) {
                                return 'Please enter a valid number of adults';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          from_to_textfield(
                              context, 'Destination', to, 'to', 'package'),
                        ],
                      ),
                    ),
                  ),
                  TealButton(
                      text: 'Add Itinerary',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Generate packageId as a 9-digit random number
                          var packageId =
                              Random().nextInt(900000000) + 100000000;

                          // Create a new Package object
                          var newPackage = Package(
                            packageId: packageId.toString(),
                            packageName: _packageNameController.text,
                            packagePrice:
                                double.parse(_packagePriceController.text),
                            packageDescription:
                                _packageDescriptionController.text,
                            startDate: _selectedDate,
                            numOfDays: int.parse(_numOfDaysController.text),
                            rating: 0.0,
                            numOfSales: 0,
                            imgUrls: _imgUrlsController.text.split(','),
                            adults: int.parse(_adultsController.text),
                            travelAgencyId:
                                FirebaseAuth.instance.currentUser!.uid,
                            hotelPropertyId: _hotelPropertyIdController.text,
                            dayWiseDetails: [],
                            destination: to,
                          );

                          Get.to(
                            ItineraryScreen(
                              package: newPackage,
                            ),
                          );
                        }
                      },
                      bgColor: Constants.primaryColor,
                      txtColor: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PackageField extends StatefulWidget {
  PackageField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.validator,
      this.keyboardType});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  TextInputType? keyboardType;

  @override
  State<PackageField> createState() => _PackageFieldState();
}

class _PackageFieldState extends State<PackageField> {
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
      child: TextFormField(
        cursorColor: Constants.primaryColor,
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Constants.primaryColor,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          labelStyle: TextStyle(
              color:
                  _isFocused ? Constants.primaryColor : Colors.grey.shade600),
        ),
        validator: widget.validator,
      ),
    );
  }
}

Widget from_to_textfield(context, topText, bottomText, title, option) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchDestination(title: title, option: option),
      ));
    },
    child: Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withOpacity(0.2),
          // border: Border.all(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topText,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
            ),
            poppinsText(
                text: bottomText, size: 18.0, fontBold: FontWeight.w400),
          ],
        ),
      ),
    ),
  );
}
