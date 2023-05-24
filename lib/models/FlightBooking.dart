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
  String flightDepartureDate;
  String flightReturnDate;
  String returnFlightDuration;
  String returnFromCity;
  String returnToCity;
  String returnFromTime;
  String returnToTime;
  String carrierName;
  String connectingFlights;
  String adults;
  bool returnFlightExists;

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
    required this.flightDepartureDate,
    required this.flightReturnDate,
    required this.returnFlightDuration,
    required this.returnFromCity,
    required this.returnToCity,
    required this.returnFromTime,
    required this.returnToTime,
    required this.carrierName,
    required this.connectingFlights,
    required this.returnFlightExists,
    required this.adults,
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
      flightDepartureDate: json['flightDepartureDate'],
      flightReturnDate: json['flightReturnDate'],
      returnFlightDuration: json['returnFlightDuration'],
      returnFromCity: json['returnFromCity'],
      returnToCity: json['returnToCity'],
      returnFromTime: json['returnFromTime'],
      returnToTime: json['returnToTime'],
      carrierName: json['carrierName'],
      connectingFlights: json['connectingFlights'],
      returnFlightExists: json['returnFlightExists'],
      adults: json['adults'],
    );
  }
}
