import 'package:cloud_firestore/cloud_firestore.dart';

class HotelBooking {
  String bookingId;
  String bookingDate;
  String travelerId;
  String hotelId;
  String hotelRoomId;

  HotelBooking(
      {required this.bookingId,
      required this.bookingDate,
      required this.travelerId,
      required this.hotelId,
      required this.hotelRoomId});

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      travelerId: json['travelerId'],
      hotelId: json['hotelId'],
      hotelRoomId: json['hotelRoomId'],
    );
  }
}
