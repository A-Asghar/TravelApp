import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_agency/Constants.dart';

Widget poppinsText(
    {required text,
    TextAlign? textAlign,
    size = 15.0,
    FontWeight fontBold = FontWeight.w300,
    Color color = Constants.secondaryColor}) {
  return Text(
    text,
    style:
        GoogleFonts.poppins(fontSize: size, fontWeight: fontBold, color: color),
    textAlign: textAlign,
  );
}
