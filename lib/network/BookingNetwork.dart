import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/models/FlightBooking.dart';
import 'package:fyp/models/HotelBooking.dart';
import 'package:fyp/models/PackageBooking.dart';

class BookingNetwork {
  CollectionReference packageBookings =
      FirebaseFirestore.instance.collection('packageBookings');
  CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');
  CollectionReference hotelBookings =
      FirebaseFirestore.instance.collection('hotelBookings');
  CollectionReference flightBookings =
      FirebaseFirestore.instance.collection('flightBookings');

  bookPackage({required PackageBooking packageBooking}) async {
    await packageBookings.doc(packageBooking.bookingId).set({
      "bookingId": packageBooking.bookingId,
      "bookingDate": packageBooking.bookingDate,
      "travelerId": packageBooking.travelerId,
      "travelAgencyId": packageBooking.travelAgencyId,
      "packageId": packageBooking.packageId
    });

    // increment number of sales for the package
    packages
        .doc(packageBooking.packageId)
        .update({'numOfSales': FieldValue.increment(1)});
  }

  deletePackageBooking({required bookingId}) async {
    await packageBookings.doc(bookingId).delete();
  }

  getTravelerPackageBooking({required travelerId}) async {
    return await packageBookings
        .where('travelerId', isEqualTo: travelerId)
        .get();
  }

  bookFlight({required FlightBooking flightBooking}) async {
    await flightBookings.doc(flightBooking.bookingId).set({
      "bookingId": flightBooking.bookingId,
      "bookingDate": flightBooking.bookingDate,
      "travelerId": flightBooking.travelerId,
      "flightId": flightBooking.flightId,
    });
  }

  deleteFlightBooking({required bookingId}) async {
    await flightBookings.doc(bookingId).delete();
  }

  getTravelerFlightBooking({required travelerId}) async {
    return await flightBookings
        .where('travelerId', isEqualTo: travelerId)
        .get();
  }

  bookHotelRoom({required HotelBooking hotelBooking}) async {
    await hotelBookings.doc(hotelBooking.bookingId).set({
      "bookingId": hotelBooking.bookingId,
      "bookingDate": hotelBooking.bookingDate,
      "travelerId": hotelBooking.travelerId,
      "hotelId": hotelBooking.hotelId,
      "hotelRoomId": hotelBooking.hotelRoomId,
    });
  }

  deleteHotelBooking({required bookingId}) async {
    await hotelBookings.doc(bookingId).delete();
  }

  getTravelerHotelBooking({required travelerId}) async {
    return await hotelBookings.where('travelerId', isEqualTo: travelerId).get();
  }
}
