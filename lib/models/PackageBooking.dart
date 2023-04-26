class PackageBooking {
  String bookingId;
  String bookingDate;
  String travelerId;
  String travelAgencyId;
  String packageId;
  String imageUrl;
  String destination;
  String adults;
  String price;

  PackageBooking({
    required this.bookingId,
    required this.bookingDate,
    required this.travelerId,
    required this.travelAgencyId,
    required this.packageId,
    required this.imageUrl,
    required this.destination,
    required this.adults,
    required this.price,
  });

  factory PackageBooking.fromJson(Map<String, dynamic> json) {
    return PackageBooking(
      bookingId: json['bookingId'],
      bookingDate: json['bookingDate'],
      travelerId: json['travelerId'],
      travelAgencyId: json['travelAgencyId'],
      packageId: json['packageId'],
      imageUrl: json['imageUrl'],
      destination: json['destination'],
      adults: json['adults'],
      price: json['price'],
    );
  }
}
