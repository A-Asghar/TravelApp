import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget signInTextField({labelText, keyboardType = TextInputType.text, obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          labelText: '$labelText',
          labelStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.white)),
    ),
  );
}
