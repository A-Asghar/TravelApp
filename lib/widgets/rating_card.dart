import 'package:flutter/material.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/widgets/poppinsText.dart';


Widget ratingCard(String text, Color bgColor) {
  return Container(
    height: 38,
    decoration: BoxDecoration(
      color: bgColor,
      border: Border.all(
        color: Constants.primaryColor,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: bgColor == Constants.primaryColor
                ? Colors.white
                : Constants.primaryColor,
            size: 15,
          ),
          const SizedBox(width: 10),
          poppinsText(
            text: text,
            size: 16.0,
            color: bgColor == Constants.primaryColor
                ? Colors.white
                : Constants.primaryColor,
          ),
        ],
      ),
    ),
  );
}
