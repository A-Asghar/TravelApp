class PackageBooking {
  String packageName;
  String bookingId;
  String bookingDate;
  String travelerId;
  String travelAgencyId;
  String packageId;
  String imageUrl;
  String destination;
  String adults;
  String price;
  String vacationStartDate;
  String vacationEndDate;
  String rating;
  String numOfReviews;

  PackageBooking({
    required this.packageName,
    required this.bookingId,
    required this.bookingDate,
    required this.travelerId,
    required this.travelAgencyId,
    required this.packageId,
    required this.imageUrl,
    required this.destination,
    required this.adults,
    required this.price,
    required this.vacationStartDate,
    required this.vacationEndDate,
    required this.rating,
    required this.numOfReviews,
  });

  factory PackageBooking.fromJson(Map<String, dynamic> json) {
    return PackageBooking(
      packageName: json['packageName'],
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      travelerId: json['travelerId'],
      travelAgencyId: json['travelAgencyId'],
      packageId: json['packageId'],
      imageUrl: json['imageUrl'],
      destination: json['destination'],
      adults: json['adults'],
      price: json['price'],
      vacationStartDate: json['vacationStartDate'],
      vacationEndDate: json['vacationEndDate'],
      rating: json['rating'],
      numOfReviews: json['numOfReviews']
    );
  }
}
