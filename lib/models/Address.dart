import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  String city;
  String country;

  Address({
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
      };
}
