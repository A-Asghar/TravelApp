class Flight {
  Flight(
      {required this.oneWay,
      required this.numberOfBookableSeats,
      required this.itineraries,
      required this.price,
      required this.validatingAirlineCodes,
      required this.fareDetailsBySegment});

  bool oneWay;
  int numberOfBookableSeats;
  List<Itinerary> itineraries;
  FlightPrice price;
  List<dynamic> validatingAirlineCodes;
  List<FareDetailsBySegment> fareDetailsBySegment;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        oneWay: json["oneWay"],
        numberOfBookableSeats: json["numberOfBookableSeats"],
        itineraries: List<Itinerary>.from(
            json["itineraries"].map((x) => Itinerary.fromJson(x))),
        price: FlightPrice.fromJson(json["price"]),
        validatingAirlineCodes:
            List<String>.from(json["validatingAirlineCodes"].map((x) => x)),
        fareDetailsBySegment: List<FareDetailsBySegment>.from(
            json["fareDetailsBySegment"]
                .map((x) => FareDetailsBySegment.fromJson(x))),
      );
}

class Itinerary {
  Itinerary({
    required this.duration,
    required this.segments,
  });

  String duration;
  List<Segment> segments;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        duration: json["duration"],
        segments: List<Segment>.from(
            json["segments"].map((x) => Segment.fromJson(x))),
      );
}

class Segment {
  Segment(
      {required this.departure,
      required this.arrival,
      required this.carrierCode,
      required this.aircraft,
      required this.duration});

  Arrival departure;
  Arrival arrival;
  String carrierCode;
  Aircraft aircraft;
  String duration;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        departure: Arrival.fromJson(json["departure"]),
        arrival: Arrival.fromJson(json["arrival"]),
        carrierCode: json["carrierCode"],
        aircraft: Aircraft.fromJson(json["aircraft"]),
        duration: json["duration"],
      );
}

class Aircraft {
  Aircraft({
    required this.code,
  });

  String code;

  factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        code: json["code"],
      );
}

class Arrival {
  Arrival({
    required this.iataCode,
    required this.at,
  });

  String iataCode;
  DateTime at;

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        iataCode: json["iataCode"],
        at: DateTime.parse(json["at"]),
      );
}

class FlightPrice {
  FlightPrice({
    required this.currency,
    required this.total,
    required this.grandTotal,
  });

  String currency;
  String total;
  String grandTotal;

  factory FlightPrice.fromJson(Map<String, dynamic> json) => FlightPrice(
        currency: json["currency"],
        total: json["total"],
        grandTotal: json["grandTotal"],
      );
}

class FareDetailsBySegment {
  FareDetailsBySegment({
    required this.cabin,
  });

  String cabin;

  factory FareDetailsBySegment.fromJson(Map<String, dynamic> json) =>
      FareDetailsBySegment(
        cabin: json["cabin"],
      );
}
