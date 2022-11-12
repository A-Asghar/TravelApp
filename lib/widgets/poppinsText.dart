import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget poppinsText(
    {required text,
    size = 15.0,
    FontWeight fontBold = FontWeight.w300,
    Color color = Colors.black}) {
  return Text(
    text,
    style: GoogleFonts.poppins(fontSize: size, fontWeight: fontBold, color: color),
  );
}
