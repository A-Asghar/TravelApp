import 'package:cloud_firestore/cloud_firestore.dart';

class PackageBooking {
  String bookingId;
  DateTime bookingDate;
  String travelerId;
  String travelAgencyId;
  String packageId;

  PackageBooking(
      {required this.bookingId,
      required this.bookingDate,
      required this.travelerId,
      required this.travelAgencyId,
      required this.packageId});

  factory PackageBooking.fromJson(Map<String, dynamic> json) {
    return PackageBooking(
      bookingId: json['bookingId'],
      bookingDate: (json['bookingDate'] as Timestamp).toDate(),
      travelerId: json['travelerId'],
      travelAgencyId: json['travelAgencyId'],
      packageId: json['packageId'],
    );
  }
}
