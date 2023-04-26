import 'package:cloud_firestore/cloud_firestore.dart';

class FlightBooking {
  String bookingId;
  String bookingDate;
  String travelerId;
  String flightId;

  FlightBooking(
      {required this.bookingId,
      required this.bookingDate,
      required this.travelerId,
      required this.flightId});

  factory FlightBooking.fromJson(Map<String, dynamic> json) {
    return FlightBooking(
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      travelerId: json['travelerId'],
      flightId: json['flightId'],
    );
  }
}
