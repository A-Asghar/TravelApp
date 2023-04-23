import 'package:flutter/material.dart';
import 'package:travel_agency/Constants.dart';
import 'package:travel_agency/widgets/poppinsText.dart';

void customErrorDialog(BuildContext context, text) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: poppinsText(
              text: 'An error has occurred',
              fontBold: FontWeight.bold,
              size: 20.0,
              color: Colors.red),
          content: poppinsText(text: text, size: 16.0, fontBold: FontWeight.w500),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: poppinsText(text: 'Ok', color: Constants.primaryColor))
          ],
        );
      });
}