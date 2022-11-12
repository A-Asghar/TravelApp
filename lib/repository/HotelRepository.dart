import 'dart:convert';

import '../models/Hotel.dart';
import '../models/HotelReview.dart';
import '../network.dart';

class HotelRepository {
  // https://rapidapi.com/apidojo/api/hotels4
  Network network = Network();
  hotelSearch({required String city}) async {
    // TODO: implement propertiesList params into hotelSearch

    var response = await network.hotelSearch(city);

    response = jsonDecode(response);

    var destinationID =
        response['suggestions'][2]['entities'][0]['destinationId'];
    // print('destinationID : $destinationID');

    var response2 = await network.propertiesList(
        destinationId: destinationID,
        adults: 2,
        checkIn: '2022-10-09',
        checkOut: '2022-10-10',
        pageNumber: 1);

    response2 = jsonDecode(response2);

    var data = response2['data']['body']['searchResults']['results'];

    List<Hotel> hotels = data
        .map<Hotel>((h) => Hotel(
            id: h['id'],
            hotelName: h['name'],
            starRating: h['starRating'],
            streetAddress: h['address']['streetAddress'],
            price: h['ratePlan']['price']['current'],
            imageUrl: h['optimizedThumbUrls']['srpDesktop']))
        .toList();

    print('hotels.length: ${hotels.length}');
    hotels.forEach((h) {
      print(h.hotelName);
    });

    print(hotels[0].imageUrl);

    return hotels;
  }

  getHotelImages({required id}) async {
    var response = await network.getHotelImages(id);
    response = jsonDecode(response);

    var data = response['hotelImages'];
    List hotelImages =
        data.map((i) => i['baseUrl'].replaceAll('_{size}', '')).toList();

    // print('hotelImages.length: ${hotelImages.length}');
    // print(hotelImages[0]);
    return hotelImages;
  }

  getHotelReviews({required id}) async {
    var response = await network.getHotelReviews(id);
    response = jsonDecode(response);

    var groups = response['data']['reviews']['body']['reviewContent']['reviews']
        ['hermes']['groups'];

    List items = groups.map((i) => i['items']).toList();
    // print('items.length : ${items.length}');

    List<HotelReview> reviews = [];
    for (int i = 0; i < items.length; i++) {
      List<HotelReview> temp = items[i]
          .map((l) => HotelReview(
              reviewerName: l['reviewer']['name'],
              rating: l['rating'].toString(),
              description: l['description']))
          .toList()
          .cast<HotelReview>();
      reviews.addAll(temp);
    }
    print(reviews.length);
    print(reviews[8].reviewerName);

    return reviews;
  }
}
