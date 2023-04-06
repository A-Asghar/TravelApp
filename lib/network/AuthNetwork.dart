import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/Users.dart';
import '../providers/user_provider.dart';

class AuthNetwork {
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static createNewUser({required email, required password, required String role}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      await users.doc(user.user!.uid).set({
        'uid': user.user!.uid,
        'email': email,
        'role': role,
        'name': '',
        'address': '',
        'dateOfBirth': '',
        'phoneNumber': '',
        'gender': '',
        'profilePhotoUrl': '',
        'searchedCities': [],
      });
    });
    await setUserInProvider();
  }

  static login({required email, required password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    await setUserInProvider();
  }

  // static signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser =
  //       await GoogleSignIn(scopes: <String>["email"]).signIn();

  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   bool? exists;
  //   await FirebaseAuth.instance
  //       .signInWithCredential(credential)
  //       .then((user) async {
  //     var doc = await users.doc(user.user!.uid).get();

  //     exists = doc.exists;

  //     if (!exists!) {
  //       await users.doc(user.user!.uid).set({
  //         'uid': user.user!.uid,
  //         'email': user.user!.email,
  //         'name': '',
  //         'address': '',
  //         'dateOfBirth': '',
  //         'phoneNumber': '',
  //         'gender': '',
  //         'profilePhotoUrl': '',
  //         'searchedCities': [],
  //       });
  //     }
  //   });
  //   await setUserInProvider();
  //   return exists;
  // }

  static createUserProfile(
      {required User signedInUser, required Users user}) async {
    users.doc(signedInUser.uid).update({
      'name': user.name,
      'address': user.address,
      'dateOfBirth': user.dateOfBirth,
      'phoneNumber': user.phoneNumber,
      'gender': user.gender,
      'profilePhotoUrl': user.profilePhotoUrl,
      'searchedCities': [],
    });
    await setUserInProvider();
  }

  static setUserInProvider() async {
    final UserProvider controller = Get.put(UserProvider());

    var document =
        await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    controller.user = Users.fromJson(document.data() as Map<String, dynamic>);
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Check if the user already exists in the Firebase collection
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    if (user.additionalUserInfo!.isNewUser) {
      // Create a new user in the Firebase collection
      final currentUser = FirebaseAuth.instance.currentUser!;
      final newUser = Users(
        name: currentUser.displayName!,
        email: currentUser.email!,
        role: "Agency",
        phoneNumber: "",
        profilePhotoUrl: currentUser.photoURL!,
        dateOfBirth: "",
        gender: "",
        address: "",
        searchedCities: [],
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set(newUser.toJson());
    }

    // Once signed in, return the UserCredential
    await setUserInProvider();
    return user;
  }
  
}
