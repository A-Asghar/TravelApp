import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/models/PackageBooking.dart';

import '../models/Package.dart';
import '../network/PackageNetwork.dart';

class PackageRepository {
  PackageNetwork network = PackageNetwork();
  addPackage({required Package package}) async {
    network.addPackage(package: package);
  }

  deletePackage({required String packageId}) async {
    network.deletePackage(packageId: packageId);
  }

  getAllPackages() async {
    List<Package> packages = [];
    var response = await network.getAllPackages();
    response.docs.forEach((snapshot) {
      packages.add(Package.fromJson(snapshot.data()));
    });

    return packages;
  }

  updatePackage({required Package package}) async {
    await network.updatePackage(package: package);
  }

  makePackageBooking(
      {required travelerId,
      required travelAgencyId,
      required packageId}) async {
    var now = DateTime.now();
    String bookingId = 'booking_${now.millisecondsSinceEpoch}_$travelerId';
    DateTime bookingDate = now;
    await network.makePackageBooking(
        packageBooking: PackageBooking(
            bookingId: bookingId,
            bookingDate: bookingDate,
            travelerId: FirebaseAuth.instance.currentUser!.uid,
            travelAgencyId: travelAgencyId,
            packageId: packageId));
  }

  getTravelerBookings({required travelerId}) async {
    List<PackageBooking> bookings = [];
    var response = await network.getTravelerBooking(travelerId: travelerId);
    response.docs.forEach((snapshot) {
      bookings.add(PackageBooking.fromJson(snapshot.data()));
    });
  }

  getTravelAgencyBooking({required travelAgencyId}) async {
    List<PackageBooking> bookings = [];
    var response = await network.getTravelerBooking(travelerId: travelAgencyId);
    response.docs.forEach((snapshot) {
      bookings.add(PackageBooking.fromJson(snapshot.data()));
    });
  }
}
