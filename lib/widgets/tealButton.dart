import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';

import '../Constants.dart';

class TealButton extends StatelessWidget {
  const TealButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50),
            backgroundColor: Constants.primaryColor),
        onPressed: onPressed,
        child: poppinsText(
            text: text, color: Colors.white, fontBold: FontWeight.w500),
      ),
    );
  }
}
