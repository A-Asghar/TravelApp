import 'package:flutter/material.dart';
import 'package:fyp/Constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textFieldController;
  final Widget prefix;
  final Widget sufix;
  final bool hideText;
  final TextInputType keyboardType;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.textFieldController,
      required this.prefix,
      required this.sufix,
      this.hideText = false,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: Get.width,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.hideText,
        controller: widget.textFieldController,
        style: GoogleFonts.poppins(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          // errorText: widget.showError ? 'This field can not be empty' : null,
          contentPadding: const EdgeInsets.only(top: 15),
          fillColor: Constants.secondaryColor.withOpacity(0.05),
          filled: true,
          hintText: widget.hintText,
          suffixIcon: widget.sufix,
          prefixIcon: widget.prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xff9E9E9E),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
