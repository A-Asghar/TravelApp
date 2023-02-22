import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fyp/repository/PackageRepository.dart';
import '../widgets/tealButton.dart';
import 'package:fyp/models/Package.dart';
PackageRepository pak = PackageRepository();
class PackageForm extends StatefulWidget {
  @override
  _PackageFormState createState() => _PackageFormState();
}

class _PackageFormState extends State<PackageForm> {
  final List<Package> _packages = [];
  final _formKey = GlobalKey<FormState>();
  final _packageNameController = TextEditingController();
  final _packagePriceController = TextEditingController();
  final _packageDescriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _numOfDaysController = TextEditingController();
  final _imgUrlsController = TextEditingController();
  final _adultsController = TextEditingController();
  final _travelAgencyIdController = TextEditingController();
  final _hotelPropertyIdController = TextEditingController();
  final _dayWiseDetailsController = TextEditingController();
  final _destinationController = TextEditingController();
  late DateTime _selectedDate;
  late DateTime _selectedEndDate;

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

      final storageRef = FirebaseStorage.instance.ref().child('packages/${DateTime.now().toString()}');
      final uploadTask = storageRef.putData(imageData);

      await uploadTask.whenComplete(() => null);

      final url = await storageRef.getDownloadURL();
      setState(() {
        _imgUrls.add(url);
      });
    }
  }

  List<Asset> _images = <Asset>[];
  String _error = 'No Error Dectected';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Package'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _packageNameController,
                  decoration: InputDecoration(
                    labelText: 'Package Name',
                    hintText: 'Enter the package name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please enter the package name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _packagePriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Package Price',
                    hintText: 'Enter the package price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
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
                TextFormField(
                  controller: _packageDescriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Package Description',
                    hintText: 'Enter the package description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
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
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                setState(() {
                                  _selectedDate = selectedDate;
                                  _startDateController.text =
                                      DateFormat('yyyy-MM-dd').format(selectedDate);
                                });
                              }
                            });
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _startDateController,
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                hintText: 'Select a start date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
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
                      SizedBox(width: 6.0),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            ).then((selectedEndDate) {
                              if (selectedEndDate != null) {
                                setState(() {
                                  _selectedEndDate = selectedEndDate;
                                  _endDateController.text =
                                      DateFormat('yyyy-MM-dd').format(selectedEndDate);
                                });
                              }
                            });
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _endDateController,
                              decoration: InputDecoration(
                                labelText: 'End Date',
                                hintText: 'Select a End date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.2),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'Please select a end date';
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
                TextFormField(
                  controller: _numOfDaysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Days',
                    hintText: 'Enter the number of days',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
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
                TealButton(onPressed: _loadAssets, text: 'Add images', ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _adultsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of Adults',
                    hintText: 'Enter the number of adults',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
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
                TextFormField(
                  controller: _dayWiseDetailsController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Day-wise Details',
                    hintText: 'Enter the day-wise details',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _destinationController,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                    hintText: 'Enter the destination',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Please enter the destination';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TealButton(text: 'Create Package', onPressed: (){
                  if (_formKey.currentState?.validate() ?? false) {
                    // Generate packageId as a 9-digit random number
                    var packageId = Random().nextInt(900000000) + 100000000;

                    // Create a new Package object
                    var package1 = Package(
                      packageId: packageId.toString(),
                      packageName: _packageNameController.text,
                      packagePrice:
                      double.parse(_packagePriceController.text),
                      packageDescription: _packageDescriptionController.text,
                      startDate: _selectedDate,
                      endDate: _selectedEndDate,
                      numOfDays: int.parse(_numOfDaysController.text),
                      rating: 0.0,
                      numOfSales: 0,
                      imgUrls: _imgUrlsController.text.split(','),
                      adults: int.parse(_adultsController.text),
                      travelAgencyId: _travelAgencyIdController.text,
                      hotelPropertyId: _hotelPropertyIdController.text,
                      dayWiseDetails:
                      _dayWiseDetailsController.text.isNotEmpty
                          ? _dayWiseDetailsController.text.split(',')
                          : null,
                      destination: _destinationController.text,
                    );

                    // Add the new package to the list of packages
                    _packages.add(package1);
                    pak.addPackage(package: package1);
                    // Show a snackbar message to indicate success
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Package created successfully'),
                      ),
                    );

                    // Clear the form
                    _packageNameController.clear();
                    _packagePriceController.clear();
                    _packageDescriptionController.clear();
                    _startDateController.clear();
                    _endDateController.clear();
                    _numOfDaysController.clear();
                    _imgUrlsController.clear();
                    _adultsController.clear();
                    _travelAgencyIdController.clear();
                    _hotelPropertyIdController.clear();
                    _dayWiseDetailsController.clear();
                    _destinationController.clear();
                    setState(() {
                      _selectedDate ??= DateTime.now();
                    });
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Package {
//   final String packageId;
//   final String packageName;
//   final double packagePrice;
//   final String packageDescription;
//   final DateTime startDate;
//   final DateTime endDate;
//   final int numOfDays;
//   final double rating;
//   final int numOfSales;
//   final List<String> imgUrls;
//   final int adults;
//   final String travelAgencyId;
//   final String hotelPropertyId;
//   final List<String>? dayWiseDetails;
//   final String destination;
//
//   Package({
//     required this.packageId,
//     required this.packageName,
//     required this.packagePrice,
//     required this.packageDescription,
//     required this.startDate,
//     required this.endDate,
//     required this.numOfDays,
//     required this.rating,
//     required this.numOfSales,
//     required this.imgUrls,
//     required this.adults,
//     required this.travelAgencyId,
//     required this.hotelPropertyId,
//     this.dayWiseDetails,
//     required this.destination,
//   });
// }
