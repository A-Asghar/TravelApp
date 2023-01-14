import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Package.dart';

class PackageNetwork {
  CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');
  addPackage({required Package package}) async {
    await packages.doc(package.packageId).set({
      "packageId": package.packageId,
      "packageName": package.packageName,
      "packagePrice": package.packagePrice,
      "packageDescription": package.packageDescription,
      "startDate": package.startDate,
      "endDate": package.endDate,
      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails":package.dayWiseDetails
    });
  }

  deletePackage({required String packageId}) async {
    await packages.doc(packageId).delete();
  }

  getAllPackages() async {
    final snapshots = await packages.get();
    return snapshots;
  }

  updatePackage({required Package package}) async {
    await packages.doc(package.packageId).update({
      "packageId": package.packageId,
      "packageName": package.packageName,
      "packagePrice": package.packagePrice,
      "packageDescription": package.packageDescription,
      "startDate": package.startDate,
      "endDate": package.endDate,
      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails":package.dayWiseDetails
    });
  }
}
