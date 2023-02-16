import 'package:flutter/material.dart';
import 'package:fyp/repository/PackageRepository.dart';
import 'package:fyp/widgets/tealButton.dart';

import '../models/Package.dart';

class EditPackage extends StatefulWidget {
  const EditPackage({Key? key, required this.package}) : super(key: key);
  final Package package;
  @override
  State<EditPackage> createState() => _EditPackageState();
}

class _EditPackageState extends State<EditPackage> {
  TextEditingController packageName = TextEditingController();
  TextEditingController packagePrice = TextEditingController();
  TextEditingController packageDescription = TextEditingController();
  TextEditingController adults = TextEditingController();
  TextEditingController imgUrls = TextEditingController();
  TextEditingController hotelPropertyId = TextEditingController();
  TextEditingController destination = TextEditingController();
  late double rating;
  late int numOfSales;
  late String travelAgencyId;
  DateTime startDate = DateTime.now();
  int numOfDays = 0;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    packageName.text = widget.package.packageName;
    packagePrice.text = widget.package.packagePrice.toString();
    packageDescription.text = widget.package.packageDescription;
    adults.text = widget.package.adults.toString();
    imgUrls.text = widget.package.imgUrls.join(', ');
    hotelPropertyId.text = widget.package.hotelPropertyId;
    startDate = widget.package.startDate;
    numOfDays = widget.package.numOfDays;
    rating = widget.package.rating;
    numOfSales = widget.package.numOfSales;
    travelAgencyId = widget.package.travelAgencyId;
    destination.text = widget.package.destination;

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

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(widget.package.packageId),
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
              controller: packageDescription,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'packageDescription'),
            ),
            TextField(
              controller: destination,
              decoration: InputDecoration(hintText: 'Package Destination'),
            ),
            TextButton(
                onPressed: () {
                  _selectDate(context);
                  startDate = selectedDate;
                  setState(() {});
                },
                child: Text('Start Date')),
            TextField(
              controller: packageDescription,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Number of Days'),
            ),
            Text(widget.package.rating.toString()),
            Text(widget.package.numOfSales.toString()),
            Text(widget.package.travelAgencyId),
            TextField(
              controller: adults,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Package adults'),
            ),
            TextField(
              controller: imgUrls,
              decoration: InputDecoration(hintText: 'Package imgUrls'),
            ),
            TextField(
              controller: hotelPropertyId,
              decoration: InputDecoration(hintText: 'Package hotelPropertyId'),
            ),
            TealButton(
                text: 'Update',
                onPressed: () {
                  PackageRepository p = PackageRepository();
                  p.updatePackage(
                      package: Package(
                          packageId: widget.package.packageId,
                          packageName: packageName.text,
                          packagePrice: double.parse(packagePrice.text),
                          packageDescription: packageDescription.text,
                          startDate: startDate,
                          numOfDays: numOfDays,
                          rating: rating,
                          numOfSales: numOfSales,
                          imgUrls: imgUrls.text.split(','),
                          adults: int.parse(adults.text),
                          travelAgencyId: travelAgencyId,
                          hotelPropertyId: hotelPropertyId.text,
                          destination: destination.text));
                })
          ],
        ),
      ),
    );
  }
}
