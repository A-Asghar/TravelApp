class Users {
  String name;
  String email;
  String role;
  String phoneNumber;
  String profilePhotoUrl;
  String dateOfBirth;
  String gender;
  String address;
  List searchedCities;

  Users({
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.profilePhotoUrl,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.searchedCities,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        name: json["name"],
        email: json["email"],
        role: json['role'],
        phoneNumber: json["phoneNumber"],
        profilePhotoUrl: json["profilePhotoUrl"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        address: json["address"],
        searchedCities: json["searchedCities"],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
        'phoneNumber': phoneNumber,
        'profilePhotoUrl': profilePhotoUrl,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'address': address,
        'searchedCities': searchedCities,
      };
}
