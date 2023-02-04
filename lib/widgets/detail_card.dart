import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';

Widget detailCard(String text) {
  return Column(
    children: [
      Container(
        height: 32,
        width: 32,
      ),
      const SizedBox(height: 8),
      poppinsText(text: text, size: 12.0),
    ],
  );
}
