class HotelBooking {
  String bookingId;
  String bookingDate;
  String travelerId;
  String hotelId;
  String hotelRoomId;
  String hotelName;
  String hotelLocation;
  String imageUrl;
  String hotelCheckInDate;
  String hotelCheckOutDate;
  String price;
  String rating;
  String numOfReviews;
  String adults;

  HotelBooking(
      {required this.bookingId,
      required this.bookingDate,
      required this.travelerId,
      required this.hotelId,
      required this.hotelRoomId,
      required this.hotelName,
      required this.hotelLocation,
      required this.imageUrl,
      required this.hotelCheckInDate,
      required this.hotelCheckOutDate,
      required this.price,
      required this.rating,
      required this.numOfReviews,
      required this.adults});

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
      hotelCheckInDate: json['hotelCheckInDate'],
      hotelCheckOutDate: json['hotelCheckOutDate'],
      price: json['price'],
      rating: json['rating'],
      numOfReviews: json['numOfReviews'],
      adults: json['adults'],
    );
  }
}
