class Package {
  String packageId;
  String packageName;
  double packagePrice;
  String packageDescription;
  DateTime startDate;
  DateTime endDate;
  double rating;
  int numOfSales;
  List<String> imgUrls;
  int adults;
  String travelAgencyId;
  String hotelPropertyId;
  List<String>? dayWiseDetails;

  Package(
      {required this.packageId,
      required this.packageName,
      required this.packagePrice,
      required this.packageDescription,
      required this.startDate,
      required this.endDate,
      required this.rating,
      required this.numOfSales,
      required this.imgUrls,
      required this.adults,
      required this.travelAgencyId,
      required this.hotelPropertyId,
      this.dayWiseDetails});

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageId: json["packageId"],
        packageName: json["packageName"],
        packagePrice: json["packagePrice"].toDouble(),
        packageDescription: json["packageDescription"],
        startDate: json["startDate"].toDate(),
        endDate: json["endDate"].toDate(),
        rating: json["rating"].toDouble(),
        numOfSales: json["numOfSales"],
        imgUrls: List<String>.from(json["imgUrls"]!.map((x) => x)),
        dayWiseDetails: json["dayWiseDetails"] == null
            ? null
            : List<String>.from(json["dayWiseDetails"]!.map((x) => x)),
        adults: json["adults"],
        travelAgencyId: json["travelAgencyId"],
        hotelPropertyId: json["hotelPropertyId"],
      );
}
