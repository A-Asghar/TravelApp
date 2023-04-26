class FlightBooking {
  String bookingId;
  String bookingDate;
  String travelerId;
  String flightId;
  String flightDuration;
  String fromCity;
  String toCity;
  String fromTime;
  String toTime;
  String cabin;
  String price;

  FlightBooking({
    required this.bookingId,
    required this.bookingDate,
    required this.travelerId,
    required this.flightId,
    required this.flightDuration,
    required this.fromCity,
    required this.toCity,
    required this.fromTime,
    required this.toTime,
    required this.cabin,
    required this.price,
  });

  factory FlightBooking.fromJson(Map<String, dynamic> json) {
    return FlightBooking(
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      travelerId: json['travelerId'],
      flightId: json['flightId'],
      flightDuration: json['flightDuration'],
      fromCity: json['fromCity'],
      toCity: json['toCity'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      cabin: json['cabin'],
      price: json['price'],
    );
  }
}
