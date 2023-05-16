

class HotelBooking {
  String bookingId;
  String bookingDate;
  String travelerId;
  String hotelId;
  String hotelRoomId;
  String hotelName;
  String hotelLocation;
  String imageUrl;

  HotelBooking(
      {required this.bookingId,
      required this.bookingDate,
      required this.travelerId,
      required this.hotelId,
      required this.hotelRoomId,
      required this.hotelName,
      required this.hotelLocation,
      required this.imageUrl,
      });

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      travelerId: json['travelerId'],
      hotelId: json['hotelId'],
      hotelRoomId: json['hotelRoomId'],
      hotelName: json['hotelName'],
      hotelLocation: json['hotelLocation'],
      imageUrl: json['imageUrl'],
    );
  }
}
