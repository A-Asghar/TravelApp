import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/loading_provider.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/screens/package/add_package.dart';
import 'package:travel_agency/screens/package/edit_itinerary_screen.dart';
import 'package:travel_agency/screens/package/package_list_screen.dart';
import 'package:travel_agency/widgets/custom_error_dialog.dart';
import 'package:travel_agency/widgets/lottie_loader.dart';
import 'package:travel_agency/widgets/pop_button.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/tealButton.dart';

class EditPackageForm extends StatefulWidget {
  const EditPackageForm({Key? key, required this.package, required this.index})
      : super(key: key);

  final Package package;
  final int index;

  @override
  _EditPackageFormState createState() => _EditPackageFormState();
}

class _EditPackageFormState extends State<EditPackageForm> {
  PackageNetwork pak = PackageNetwork();
  final _formKey = GlobalKey<FormState>();
  final _packageNameController = TextEditingController();
  final _packagePriceController = TextEditingController();
  final _packageDescriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _numOfDaysController = TextEditingController();
  final _imgUrlsController = TextEditingController();
  final _adultsController = TextEditingController();
  final _hotelPropertyIdController = TextEditingController();
  final _destinationController = TextEditingController();
  late DateTime _selectedDate;
  double averageRating = 0.0;

  List<String> _imgUrls = <String>[];
  bool isValidated = true;
  bool isImageLoading = false;

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
      context.read<LoadingProvider>().loadingUpdate = await "Uploading Images";
      setState(() => isImageLoading = true);
      await _uploadImagesToFirebase();
      setState(() => isImageLoading = false);
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

  @override
  void initState() {
    super.initState();
    _packageNameController.text = widget.package.packageName;
    _packageDescriptionController.text = widget.package.packageDescription;
    _packagePriceController.text = widget.package.packagePrice.toString();
    _adultsController.text = widget.package.adults.toString();
    _startDateController.text = widget.package.startDate;
    _selectedDate = DateTime.parse(widget.package.startDate);
    _numOfDaysController.text = widget.package.numOfDays.toString();
    _destinationController.text = widget.package.destination;
    _hotelPropertyIdController.text = widget.package.hotelPropertyId;
    _imgUrlsController.text =
        widget.package.imgUrls.toString().replaceAll(RegExp(r'\[.*?\]'), '');
    averageRating = pak.calculateAverageRating(context);
  }

  List<Asset> _images = <Asset>[];
  String _error = 'No Error Dectected';
  @override
  Widget build(BuildContext context) {
    String to = context.watch<PackageProvider>().to.city == ''
        ? widget.package.destination
        : context.watch<PackageProvider>().to.city;
    _imgUrls = widget.package.imgUrls;
    return Scaffold(
      appBar: isImageLoading
          ? null
          : AppBar(
              title: poppinsText(
                  text: 'Edit Package',
                  color: Colors.white,
                  size: 24.0,
                  fontBold: FontWeight.w600),
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: PopButton(
                onTap: () {
                  Navigator.pop(context);
                  context.read<PackageProvider>().clearDestination();
                },
              ),
              backgroundColor: Colors.teal,
            ),
      body: isImageLoading
          ? lottieLoader(context)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: isValidated
                        ? MediaQuery.of(context).size.height * 0.88
                        : MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 10.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  dialogTheme: DialogTheme(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                  primarySwatch: Colors.teal,
                                                  colorScheme:
                                                      ColorScheme.light(
                                                          primary: Colors.teal),
                                                ),
                                                child: child ?? Container(),
                                              );
                                            }).then((selectedDate) {
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
                              from_to_textfield(
                                  context, 'Destination', to, 'to', 'package'),
                            ],
                          ),
                        ),
                        isImageLoading
                            ? Container(
                                height: 10,
                              )
                            : TealButton(
                                text: 'Edit Itinerary',
                                onPressed: () {
                                  var editedPackage = Package(
                                    packageId: widget.package.packageId,
                                    packageName: _packageNameController.text,
                                    packagePrice: double.parse(
                                        _packagePriceController.text),
                                    packageDescription:
                                        _packageDescriptionController.text,
                                    startDate: _startDateController.text,
                                    numOfDays:
                                        int.parse(_numOfDaysController.text),
                                    rating: averageRating,
                                    numOfSales: 0,
                                    imgUrls: _imgUrls,
                                    adults: int.parse(_adultsController.text),
                                    travelAgencyId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    hotelPropertyId:
                                        _hotelPropertyIdController.text,
                                    dayWiseDetails:
                                        widget.package.dayWiseDetails,
                                    destination: _destinationController.text,
                                    packageReviews:
                                        widget.package.packageReviews,
                                  );

                                  Get.to(
                                      EditItineraryScreen(
                                        package: editedPackage,
                                        index: widget.index,
                                      ),
                                      transition: Transition.fade);
                                },
                                bgColor: Constants.primaryColor,
                                txtColor: Colors.white),
                        isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Constants.primaryColor,
                                ),
                              )
                            : TealButton(
                                text: 'Edit Package',
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    // Create a new Package object
                                    var editedPackage = Package(
                                      packageId: widget.package.packageId,
                                      packageName: _packageNameController.text,
                                      packagePrice: double.parse(
                                          _packagePriceController.text),
                                      packageDescription:
                                          _packageDescriptionController.text,
                                      startDate: _startDateController.text,
                                      numOfDays:
                                          int.parse(_numOfDaysController.text),
                                      rating: widget.package.rating,
                                      numOfSales: widget.package.numOfSales,
                                      imgUrls: _imgUrls,
                                      adults: int.parse(_adultsController.text),
                                      travelAgencyId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      hotelPropertyId:
                                          _hotelPropertyIdController.text,
                                      dayWiseDetails:
                                          widget.package.dayWiseDetails,
                                      destination: _destinationController.text,
                                      packageReviews:
                                          widget.package.packageReviews,
                                    );
                                    print("edited package: " +
                                        editedPackage.adults.toString());

                                    context
                                            .read<PackageProvider>()
                                            .agencyPackages[widget.index] =
                                        editedPackage;

                                    print("from provider: " +
                                        context
                                            .read<PackageProvider>()
                                            .agencyPackages[widget.index]
                                            .adults
                                            .toString());

                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await pak.updatePackage(
                                          package: editedPackage);
                                      context
                                              .read<PackageProvider>()
                                              .agencyPackages =
                                          await pak.fetchAgencyPackages(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  PackageListScreen())));
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      // Show a snackbar message to indicate success
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: poppinsText(
                                              text:
                                                  'Package updated successfully',
                                              color: Colors.white,
                                              size: 16.0,
                                              fontBold: FontWeight.w400),
                                          backgroundColor:
                                              Constants.primaryColor,
                                        ),
                                      );
                                      setState(() {});
                                    } on FirebaseException catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  } else {
                                    setState(() => isValidated = false);
                                  }
                                },
                                bgColor: Constants.primaryColor,
                                txtColor: Colors.white,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
