import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';

import '../Constants.dart';

class TealButton extends StatelessWidget {
  const TealButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.bgColor,
      required this.txtColor})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color txtColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: bgColor,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
            child: poppinsText(
                text: text, color: txtColor, fontBold: FontWeight.w500)),
      ),
    );
  }
}
