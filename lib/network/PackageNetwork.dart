import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/PackageBooking.dart';

import '../models/Package.dart';

class PackageNetwork {
  CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');
  CollectionReference packageBookings =
      FirebaseFirestore.instance.collection('packageBookings');
  addPackage({required Package package}) async {
    await packages.doc(package.packageId).set({
      "packageId": package.packageId,
      "packageName": package.packageName,
      "packagePrice": package.packagePrice,
      "packageDescription": package.packageDescription,
      "startDate": package.startDate,

      "numOfDays": package.numOfDays,

      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails": package.dayWiseDetails,
      "destination": package.destination,
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

      "numOfDays": package.numOfDays,

      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails": package.dayWiseDetails
    });
  }

  makePackageBooking({required PackageBooking packageBooking}) async {
    await packageBookings.doc(packageBooking.bookingId).set({
      "bookingId": packageBooking.bookingId,
      "bookingDate": packageBooking.bookingDate,
      "travelerId": packageBooking.travelerId,
      "travelAgencyId": packageBooking.travelAgencyId,
      "packageId": packageBooking.packageId
    });

    // increment number of sales for the package
    packages
        .doc(packageBooking.packageId)
        .update({'numOfSales': FieldValue.increment(1)});
  }

  getTravelerBooking({required travelerId}) async {
    return await packageBookings
        .where('travelerId', isEqualTo: travelerId)
        .get();
  }

  getTravelAgencyBooking({required travelAgencyId}) async {
    return await packageBookings
        .where('travelAgencyId', isEqualTo: travelAgencyId)
        .get();
  }

    Future<double> calculateAverageRating(BuildContext context, packageId) async {
    double totalRating = 0.0;
    int totalReviews = 0;

    Package package = await fetchPackageById(packageId: packageId);

    package.packageReviews!.forEach((review) {
      totalRating += review.reviewRating;
      totalReviews += 1;
    });

    return totalRating / totalReviews;
  }

    Future<Package> fetchPackageById({required packageId}) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('packages')
        .where('packageId', isEqualTo: packageId)
        .get();

    Map<String, dynamic> packageData =
        snapshot.docs.first.data() as Map<String, dynamic>;
    Package package = Package.fromJson(packageData);

    return package;
  }
  
}
