import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_agency/models/package.dart';

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

  Future<List<Package>> fetchAgencyPackages(String id) async {
    List<Package> agencyPackages = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('packages')
        .where('travelAgencyId', isEqualTo: id)
        .get();
    for (var document in snapshot.docs) {
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
      "dayWiseDetails":package.dayWiseDetails,
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
      "rating": package.rating,
      "numOfSales": package.numOfSales,
      "imgUrls": package.imgUrls,
      "adults": package.adults,
      "numOfDays": package.numOfDays,
      "travelAgencyId": package.travelAgencyId,
      "hotelPropertyId": package.hotelPropertyId,
      "dayWiseDetails":package.dayWiseDetails,
      "destination": package.destination
    });
  }
}
