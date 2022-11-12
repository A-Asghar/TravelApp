import 'dart:convert';

Traveler travelerFromJson(String str) => Traveler.fromJson(json.decode(str));

String travelerToJson(Traveler data) => json.encode(data.toJson());

class Traveler {
  String name;
  String email;
  String phoneNumber;
  String profilePhotoUrl;

  Traveler({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePhotoUrl,
  });

  factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
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
