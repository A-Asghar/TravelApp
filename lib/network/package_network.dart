import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_agency/models/package.dart';
import 'package:travel_agency/providers/package_provider.dart';

class PackageNetwork {
  CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');

  Future<List<Package>> fetchPackages() async {
    List<Package> allPackages = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('packages').get();
    for (var document in snapshot.docs) {
      allPackages
          .add(Package.fromJson(document.data() as Map<String, dynamic>));
    }
    return allPackages;
  }

  getAgencyPackageBooking({required travelAgencyId}) async {
    return await FirebaseFirestore.instance
        .collection('packageBookings')
        .where('travelAgencyId', isEqualTo: travelAgencyId)
        .get();
  }

  Future<List<Package>> fetchAgencyPackages(String id) async {
    List<Package> agencyPackages = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('packages')
        .where('travelAgencyId', isEqualTo: id)
        .get();
    print("snapshot: $snapshot");
    for (var document in snapshot.docs) {
      print(document.data());
      agencyPackages
          .add(Package.fromJson(document.data() as Map<String, dynamic>));
    }
    return agencyPackages;
  }

  addPackage({required Package package}) async {
    await packages.doc(package.packageId).set({
      "packageId": package.packageId,
      "packageName": package.packageName,
      "packagePrice": package.packagePrice,
      "packageDescription": package.packageDescription,
      "startDate": package.startDate,
      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "numOfDays": package.numOfDays,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails": package.dayWiseDetails,
      "destination": package.destination,
      "packageReviews": []
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
      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "numOfDays": package.numOfDays,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails": package.dayWiseDetails,
      "destination": package.destination,
      "packageReviews": package.packageReviews,
    });
  }

  double calculateAverageRating(BuildContext context) {
    double totalRatings = 0.0;
    int reviewCount = 0;

    List<Package> packages = context.read<PackageProvider>().agencyPackages;

    packages.forEach((package) {
      package.packageReviews!.forEach((review) {
        totalRatings += review.reviewRating;
        reviewCount++;
      });
    });

    return (totalRatings / reviewCount).isNaN ? 0.0 : (totalRatings / reviewCount);
  }

  double calculateTotalSales(BuildContext context) {
    double totalSales = 0;

    List<Package> packages = context.read<PackageProvider>().agencyPackages;

    packages.forEach((package) {
      totalSales += package.numOfSales * package.packagePrice;
    });

    return totalSales;
  }

  int calculateTotalNumberOfSales(BuildContext context) {
    int totalNumberOfSales = 0;

    List<Package> packages = context.read<PackageProvider>().agencyPackages;

    packages.forEach((package) {
      totalNumberOfSales += package.numOfSales;
    });

    return totalNumberOfSales;
  }
}
