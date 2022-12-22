import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/Users.dart';

class AuthNetwork{
  static createNewUser({required email, required password}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
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

  static signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    bool? exists;
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((user) async {
      CollectionReference users =
      FirebaseFirestore.instance.collection('users');
      var doc = await users.doc(user.user!.uid).get();

      exists = doc.exists;

      if (!exists!) {
        await users.doc(user.user!.uid).set({
          'uid': user.user!.uid,
          'email': user.user!.email,
          'name': '',
          'address': '',
          'dateOfBirth': '',
          'phoneNumber': '',
          'gender': '',
          'profilePhotoUrl': ''
        });
      }
    });

    return exists;
  }

  static createUserProfile(
      {required User signedInUser, required Users user}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

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