import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/network/package_network.dart';
import 'package:travel_agency/providers/package_provider.dart';
import 'package:travel_agency/screens/auth/FillYourProfile.dart';
import 'package:travel_agency/screens/package/add_package.dart';
import 'package:travel_agency/screens/package/package_list_screen.dart';
import 'package:travel_agency/widgets/pop_button.dart';
import 'package:travel_agency/widgets/poppinsText.dart';
import 'package:travel_agency/widgets/tealButton.dart';

class EditItineraryScreen extends StatefulWidget {
  EditItineraryScreen({Key? key, required this.package, required this.index})
      : super(key: key);

  final Package package;
  final int index;

  @override
  _EditItineraryScreenState createState() => _EditItineraryScreenState();
}

class _EditItineraryScreenState extends State<EditItineraryScreen> {
  PackageNetwork pak = PackageNetwork();
  late List<TextEditingController> _controllers;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.package.numOfDays, (index) {
      // If the index is within the bounds of dayWiseDetails list,
      // return a controller with the corresponding value from the list,
      // otherwise return an empty controller.
      return index < widget.package.dayWiseDetails!.length
          ? TextEditingController(text: widget.package.dayWiseDetails![index])
          : TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: poppinsText(
            text: 'Edit Itinerary',
            size: 24.0,
            color: Colors.white,
            fontBold: FontWeight.w600),
        elevation: 0,
        leading: PopButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Constants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
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
                          for (int index = 0;
                              index < widget.package.numOfDays;
                              index++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: PackageField(
                                controller: _controllers[index],
                                labelText: 'Day ${index + 1}',
                                hintText: 'Enter detail for day ${index + 1}',
                                validator: (value) {
                                  if (value?.isEmpty ?? false) {
                                    return 'Please enter detail for day ${index + 1}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                        ],
                      ),
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
                            text: 'Edit Package',
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Add the new package to the list of packages

                                List<String> itineraryDetails = [];

                                for (final controller in _controllers) {
                                  itineraryDetails.add(controller.text);
                                }

                                widget.package.dayWiseDetails =
                                    itineraryDetails;

                                context
                                        .read<PackageProvider>()
                                        .agencyPackages[widget.index] =
                                    widget.package;

                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await pak.updatePackage(
                                      package: widget.package);
                                  context
                                          .read<PackageProvider>()
                                          .agencyPackages =
                                      await pak.fetchAgencyPackages(FirebaseAuth
                                          .instance.currentUser!.uid);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  // Show a snackbar message to indicate success
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: poppinsText(
                                          text: 'Package updated successfully',
                                          color: Colors.white,
                                          size: 16.0,
                                          fontBold: FontWeight.w400),
                                      backgroundColor: Constants.primaryColor,
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            PackageListScreen())));
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } on FirebaseException catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
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
                              }
                            },
                            bgColor: Constants.primaryColor,
                            txtColor: Colors.white,
                          ),
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
