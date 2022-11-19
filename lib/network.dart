import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fyp/repository/AccessTokenRepository.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'Constants.dart';
import 'Providers/AccessTokenProvider.dart';
import 'models/Users.dart';

class Network {
  flightOffersSearch(
    originLocationCode, // KHI
    destinationLocationCode, // DXB
    departureDate, // 2022-09-25
    returnDate, // 2022-09-27
    adults, // 1
    nonStop, // false
    travelClass, // Available values : ECONOMY, PREMIUM_ECONOMY, BUSINESS, FIRST
    maxPrice,
  ) async {
    final AccessTokenProvider controller = Get.put(AccessTokenProvider());
    AccessTokenRepository accessTokenRepository = AccessTokenRepository();

    final url = Uri.parse(
        'https://${Constants.uri}${Constants.flightSearch}?originLocationCode=$originLocationCode&destinationLocationCode=$destinationLocationCode&departureDate=$departureDate&adults=$adults${returnDate == '' ? '' : '&returnDate=$returnDate'}');


    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer ${controller.accessToken?.accessToken}',
        "accept": 'application/vnd.amadeus+json',
      },
    );

    print('Network Response status: ${response.statusCode}');
    // print('Network Response body: ${response.body}');

    if (response.statusCode == 401) {
      // print('Network Error: ');

      await accessTokenRepository.getAccessToken(getNew: true);

      response = await http.get(
        url,
        headers: {
          "Authorization": 'Bearer ${controller.accessToken?.accessToken}',
          "accept": 'application/vnd.amadeus+json',
        },
      );
    }

    return response.body;
  }

  getAccessToken() async {
    var url = Uri.https(Constants.uri, '/v1/security/oauth2/token');
    var response = await http.post(url, body: {
      'grant_type': 'client_credentials',
      'client_id': 'CF9FfomFYGbFUVGG15igLgdiGtapSK1g',
      'client_secret': 'XgukiYQGMPtShAMT',
    });
    return response;
  }

  citySearch({required String keyword}) async {
    final AccessTokenProvider controller = Get.put(AccessTokenProvider());
    AccessTokenRepository a = AccessTokenRepository();

    final url = Uri.parse(
        'https://${Constants.uri}${Constants.citySearch}?subType=CITY&keyword=$keyword&page%5Blimit%5D=10&page%5Boffset%5D=0&view=LIGHT');
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer ${controller.accessToken?.accessToken}',
        "accept": 'application/vnd.amadeus+json',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 401) {
      print('Network Error: ');

      await a.getAccessToken(getNew: true);

      response = await http.get(
        url,
        headers: {
          "Authorization": 'Bearer ${controller.accessToken?.accessToken}',
          "accept": 'application/vnd.amadeus+json',
        },
      );
    }
    return response.body;
  }

  hotelSearch(String city) async {
    final url = Uri.parse(
        'https://hotels4.p.rapidapi.com/locations/v2/search?query=$city&locale=en_US&currency=USD');

    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
      },
    );
    print('hotelSearch().statusCode: ${response.statusCode}');
    return response.body;
  }

  propertiesList(
      {required destinationId,
      required checkIn,
      required checkOut,
      required adults,
      required pageNumber}) async {
    final url = Uri.parse(
        'https://hotels4.p.rapidapi.com/properties/list?destinationId=$destinationId&pageNumber=$pageNumber&pageSize=25&checkIn=$checkIn&checkOut=$checkOut&adults$adults=1&locale=en_US&currency=USD');

    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
      },
    );
    print('propertiesList().statusCode: ${response.statusCode}');

    return response.body;
  }

  getHotelImages(id) async {
    final url = Uri.parse(
        'https://hotels4.p.rapidapi.com/properties/get-hotel-photos?id=$id');

    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
      },
    );

    print('getHotelImages().statusCode: ${response.statusCode}');

    return response.body;
  }

  getHotelReviews(id) async {
    final url =
        Uri.parse('https://hotels4.p.rapidapi.com/reviews/v2/list?hotelId=$id');

    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Host": 'hotels4.p.rapidapi.com',
        "X-RapidAPI-Key": Constants.rapidAPIKey,
      },
    );

    print('getHotelReviews().statusCode: ${response.statusCode}');

    return response.body;
  }

  static createNewUser({required email,required password}) async {
    CollectionReference users =
      FirebaseFirestore.instance.collection('users');
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async{
          await users.doc(user.user!.uid).set({
            'uid': user.user!.uid,
            'email': email,
            'name': '',
            'address': '',
            'dateOfBirth': '',
            'phoneNumber': '',
            'gender': '',
            'profilePhotoUrl': '',
          });
    });
  }

  static login({required email, required password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static signInWithGoogle() async{




    // GoogleSignInAccount? account;
    //
    //
    //   FirebaseAuth auth = FirebaseAuth.instance;
    //   User? user;
    //
    //   final GoogleSignIn googleSignIn =
    //   GoogleSignIn.standard(scopes: ["email"]);
    //
    //   account = await googleSignIn.signIn();
    //
    //   if (account != null) {
    //     final GoogleSignInAuthentication googleSignInAuthentication =
    //     await account.authentication;
    //
    //     final AuthCredential credential = GoogleAuthProvider.credential(
    //       accessToken: googleSignInAuthentication.accessToken,
    //       idToken: googleSignInAuthentication.idToken,
    //     );
    //
    //     try {
    //       final UserCredential userCredential =
    //       await auth.signInWithCredential(credential);
    //
    //       user = userCredential.user;
    //     } on FirebaseAuthException catch (e) {
    //       if (e.code == 'account-exists-with-different-credential') {
    //         // handle the error here
    //       } else if (e.code == 'invalid-credential') {
    //         // handle the error here
    //       }
    //     } catch (e) {
    //       // handle the error here
    //     }
    //   }
    //
    //   return user;

    
    
    
    
    // TODO
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();


    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    bool? exists;
    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((user) async{
      CollectionReference users =
      FirebaseFirestore.instance.collection('users');
      var doc = await users.doc(user.user!.uid).get();

      exists = doc.exists;

      if(!exists!){
        await users.doc(user.user!.uid).set({
          'uid': user.user!.uid,
          'email': user.user!.email,
          'name': '',
          'address': '',
          'dateOfBirth': '',
          'phoneNumber': '',
          'gender': '',
          'profilePhotoUrl':''
        });
      }

    });




    return exists;
  }


  static createUserProfile({required User signedInUser,required Users user}) async{
    CollectionReference users =
    FirebaseFirestore.instance.collection('users');

      users.doc(signedInUser.uid).update({
      'name': user.name,
      'address': user.address,
      'dateOfBirth': user.dateOfBirth,
      'phoneNumber': user.phoneNumber,
      'gender': user.gender,
      'profilePhotoUrl': user.profilePhotoUrl,
    });
  }


}
