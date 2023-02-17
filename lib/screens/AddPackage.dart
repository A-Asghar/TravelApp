import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp/models/Package.dart';
import 'package:fyp/widgets/tealButton.dart';

import '../repository/PackageRepository.dart';
import 'AllPackages.dart';
import 'DeletePackage.dart';

class AddPackage extends StatefulWidget {
  const AddPackage({Key? key}) : super(key: key);

  @override
  State<AddPackage> createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  TextEditingController packageName = TextEditingController();
  TextEditingController packagePrice = TextEditingController();
  TextEditingController packageDescription = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController adults = TextEditingController();
  TextEditingController imgUrls = TextEditingController();
  TextEditingController travelAgencyId = TextEditingController();
  TextEditingController hotelPropertyId = TextEditingController();
  TextEditingController destination = TextEditingController();

  DateTime startDate = DateTime.now();
  int numOfDays = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    String random9DigitNumber() {
      var random = Random();
      var number = random.nextInt(1000000000).toString();
      while (number.length < 9) {
        number = "0" + number;
      }
      return number;
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: packageName,
              decoration: InputDecoration(hintText: 'Package Name'),
            ),
            TextField(
              controller: packagePrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Package Price'),
            ),
            TextField(
              controller: destination,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Package Destination'),
            ),
            TextField(
              controller: packageDescription,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'package Description'),
            ),
            TextButton(
                onPressed: () {
                  _selectDate(context);
                  startDate = selectedDate;
                  setState(() {});
                },
                child: Text('Start Date')),
            TextField(
              controller: adults,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Number of days'),
            ),
            // TextField(
            //   controller: rating,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(hintText: 'Package rating'),
            // ),
            TextField(
              controller: adults,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Package adults'),
            ),
            TextField(
              controller: imgUrls,
              decoration: InputDecoration(hintText: 'Package imgUrls'),
            ),
            // TextField(
            //   controller: travelAgencyId,
            //   decoration: InputDecoration(hintText: 'Package travelAgencyId'),
            // ),
            TextField(
              controller: hotelPropertyId,
              decoration: InputDecoration(hintText: 'Package hotelPropertyId'),
            ),
            TealButton(
                text: 'Add',
                onPressed: () {
                  PackageRepository p = PackageRepository();
                  p.addPackage(
                    package: Package(
                        packageId: random9DigitNumber(),
                        packageName: packageName.text,
                        packagePrice: double.parse(packagePrice.text),
                        packageDescription: packageDescription.text,
                        startDate: startDate,

                        numOfDays: numOfDays,

                        rating: 0.0,
                        numOfSales: 0,
                        imgUrls: imgUrls.text.split(','),
                        adults: int.parse(adults.text),
                        travelAgencyId: random9DigitNumber(),
                        hotelPropertyId: random9DigitNumber(),
                        destination: "Aliasghars', House",
                        dayWiseDetails: []),
                  );
                }),

            TealButton(
                text: 'Delete Package',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DeletePackage(),
                  ));
                }),

            TealButton(
                text: 'Get All Packages',
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllPackages(),
                  ));
                  // PackageRepository p = PackageRepository();
                  // List<Package> packages = await p.getAllPackages();
                })
          ],
        ),
      ),
    ));
  }
}
