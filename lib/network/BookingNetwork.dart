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
      "packageName": packageBooking.packageName,
      "bookingId": packageBooking.bookingId,
      "bookingDate": packageBooking.bookingDate,
      "travelerId": packageBooking.travelerId,
      "travelAgencyId": packageBooking.travelAgencyId,
      "packageId": packageBooking.packageId,
      "price": packageBooking.price,
      "adults": packageBooking.adults,
      "destination": packageBooking.destination,
      "imageUrl": packageBooking.imageUrl,
      "vacationStartDate": packageBooking.vacationStartDate,
      "vacationEndDate": packageBooking.vacationEndDate,
      "rating": packageBooking.rating,
      "numOfReviews": packageBooking.numOfReviews,
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
      "cabin": flightBooking.cabin,
      "flightDuration": flightBooking.flightDuration,
      "fromCity": flightBooking.fromCity,
      "toCity": flightBooking.toCity,
      "fromTime": flightBooking.fromTime,
      "toTime": flightBooking.toTime,
      "price": flightBooking.price,
      "flightDepartureDate": flightBooking.flightDepartureDate,
      "flightReturnDate": flightBooking.flightReturnDate,
      "returnFlightExists": flightBooking.returnFlightExists,
      "returnFlightDuration": flightBooking.returnFlightDuration,
      "returnFromCity": flightBooking.returnFromCity,
      "returnToCity": flightBooking.returnToCity,
      "returnFromTime": flightBooking.returnFromTime,
      "returnToTime": flightBooking.returnToTime,
      "carrierName": flightBooking.carrierName,
      "adults": flightBooking.adults,
      "connectingFlights": flightBooking.connectingFlights
    });

    // Print all the values in the flightBooking object
    print("bookingId: ${flightBooking.bookingId}");
    print("bookingDate: ${flightBooking.bookingDate}");
    print("travelerId: ${flightBooking.travelerId}");
    print("flightId: ${flightBooking.flightId}");
    print("cabin: ${flightBooking.cabin}");
    print("flightDuration: ${flightBooking.flightDuration}");
    print("fromCity: ${flightBooking.fromCity}");
    print("toCity: ${flightBooking.toCity}");
    print("fromTime: ${flightBooking.fromTime}");
    print("toTime: ${flightBooking.toTime}");
    print("price: ${flightBooking.price}");
    print("flightDepartureDate: ${flightBooking.flightDepartureDate}");
    print("flightReturnDate: ${flightBooking.flightReturnDate}");
    print("returnFlightExists: ${flightBooking.returnFlightExists}");
    print("returnFlightDuration: ${flightBooking.returnFlightDuration}");
    print("returnFromCity: ${flightBooking.returnFromCity}");
    print("returnToCity: ${flightBooking.returnToCity}");
    print("returnFromTime: ${flightBooking.returnFromTime}");
    print("returnToTime: ${flightBooking.returnToTime}");
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
      "hotelName": hotelBooking.hotelName,
      "hotelLocation": hotelBooking.hotelLocation,
      "imageUrl": hotelBooking.imageUrl,
      "hotelCheckInDate": hotelBooking.hotelCheckInDate,
      "hotelCheckOutDate": hotelBooking.hotelCheckOutDate,
      "price": hotelBooking.price,
      "rating": hotelBooking.rating,
      "numOfReviews": hotelBooking.numOfReviews,
      "adults": hotelBooking.adults,
    });
  }

  deleteHotelBooking({required bookingId}) async {
    await hotelBookings.doc(bookingId).delete();
  }

  getTravelerHotelBooking({required travelerId}) async {
    return await hotelBookings.where('travelerId', isEqualTo: travelerId).get();
  }
}
