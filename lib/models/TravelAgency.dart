import 'dart:convert';

TravelAgency travelAgencyFromJson(String str) => TravelAgency.fromJson(json.decode(str));

String travelAgencyToJson(TravelAgency data) => json.encode(data.toJson());

class TravelAgency {
  TravelAgency({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePhotoUrl,
  });

  String name;
  String email;
  String phoneNumber;
  String profilePhotoUrl;

  factory TravelAgency.fromJson(Map<String, dynamic> json) => TravelAgency(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePhotoUrl: json["profilePhotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePhotoUrl": profilePhotoUrl,
      };
}
