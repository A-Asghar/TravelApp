class Users {
  String name;
  String email;
  String phoneNumber;
  String profilePhotoUrl;
  String dateOfBirth;
  String gender;
  String address;
  List searchedCities;

  Users({
    required this.name,
    required this.email,
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
        phoneNumber: json["phoneNumber"],
        profilePhotoUrl: json["profilePhotoUrl"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        address: json["address"],
        searchedCities: json["searchedCities"],
      );
}
