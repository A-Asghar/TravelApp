import 'package:travel_agency/models/review.dart';

class Package {
  String packageId;
  String packageName;
  double packagePrice;
  String packageDescription;
  String startDate;
  int numOfDays;
  double rating;
  int numOfSales;
  List<String> imgUrls;
  int adults;
  String travelAgencyId;
  String hotelPropertyId;
  List<String>? dayWiseDetails;
  String destination;
  List<Review> packageReviews;

  Package({
    required this.packageId,
    required this.packageName,
    required this.packagePrice,
    required this.packageDescription,
    required this.startDate,
    required this.numOfDays,
    required this.rating,
    required this.numOfSales,
    required this.imgUrls,
    required this.adults,
    required this.travelAgencyId,
    required this.hotelPropertyId,
    this.dayWiseDetails,
    required this.destination,
    required this.packageReviews
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      packageId: json['packageId'] as String,
      packageName: json['packageName'] as String,
      packagePrice: (json['packagePrice'] as num).toDouble(),
      packageDescription: json['packageDescription'] as String,
      startDate: json['startDate'],
      numOfDays: json['numOfDays'] as int,
      rating: (json['rating'] as num).toDouble(),
      numOfSales: json['numOfSales'] as int,
      imgUrls: List<String>.from(json['imgUrls'] as List),
      adults: json['adults'] as int,
      travelAgencyId: json['travelAgencyId'] as String,
      hotelPropertyId: json['hotelPropertyId'] as String,
      dayWiseDetails: json['dayWiseDetails'] != null ? List<String>.from(json['dayWiseDetails'] as List) : null,
      destination: json['destination'] as String,
      packageReviews: (json['packageReviews'] as List<dynamic>).map((e) => Review.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packageId': packageId,
      'packageName': packageName,
      'packagePrice': packagePrice,
      'packageDescription': packageDescription,
      'startDate': startDate,
      'numOfDays': numOfDays,
      'rating': rating,
      'numOfSales': numOfSales,
      'imgUrls': imgUrls,
      'adults': adults,
      'travelAgencyId': travelAgencyId,
      'hotelPropertyId': hotelPropertyId,
      'dayWiseDetails': dayWiseDetails,
      'destination': destination,
      'packageReviews': packageReviews!.map((e) => e.toJson()).toList(),
    };
  }
}
