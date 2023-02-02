import 'package:flutter/material.dart';
import 'package:fyp/widgets/poppinsText.dart';

import '../Constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final VoidCallback onTap;
  const CustomButton(
      {Key? key,
      required this.text,
      this.bgColor,
      this.textColor,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: bgColor ?? Constants.primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: poppinsText(
              text: text,
              size: 16.0,
              fontBold: FontWeight.w700,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
