import 'dart:convert';

Users UsersFromJson(String str) => Users.fromJson(json.decode(str));

String UsersToJson(Users data) => json.encode(data.toJson());

class Users {
  String name;
  String email;
  String phoneNumber;
  String profilePhotoUrl;
  String dateOfBirth;
  String gender;
  String address;

  Users({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePhotoUrl,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    profilePhotoUrl: json["profilePhotoUrl"],
    dateOfBirth: json["dateOfBirth"],
    gender: json["gender"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "profilePhotoUrl": profilePhotoUrl,
    "dateOfBirth": dateOfBirth,
    "gender": gender,
    "address": address,
  };
}
