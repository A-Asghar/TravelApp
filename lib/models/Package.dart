import 'dart:convert';

import 'package:fyp/models/Address.dart';
import 'package:fyp/models/TravelAgency.dart';

Package packageFromJson(String str) => Package.fromJson(json.decode(str));

String packageToJson(Package data) => json.encode(data.toJson());

class Package {
  Package({
    required this.travelAgency,
    required this.price,
    required this.name,
    required this.days,
    required this.description,
    required this.rating,
    required this.address,
    required this.packageImageUrls,
    required this.sales,
  });

  TravelAgency travelAgency;
  double price;
  String name;
  int days;
  String description;
  double rating;
  Address address;
  List<String> packageImageUrls;
  int sales;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    travelAgency: TravelAgency.fromJson(json["travelAgency"]),
    price: json["price"].toDouble(),
    name: json["name"],
    days: json["days"],
    description: json["description"],
    rating: json["rating"].toDouble(),
    address: Address.fromJson(json["address"]),
    packageImageUrls: List<String>.from(json["packageImageUrls"].map((x) => x)),
    sales: json["sales"],
  );

  Map<String, dynamic> toJson() => {
    "travelAgency": travelAgency.toJson(),
    "price": price,
    "name": name,
    "days": days,
    "description": description,
    "rating": rating,
    "address": address.toJson(),
    "packageImageUrls": List<dynamic>.from(packageImageUrls.map((x) => x)),
    "sales": sales,
  };
}
