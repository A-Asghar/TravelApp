import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textFieldController;
  final Widget prefix;
  final Widget sufix;
  final bool hideText;

  const CustomTextField(
      {Key? key,
        required this.hintText,
        required this.textFieldController,
        required this.prefix,
        required this.sufix,
        this.hideText = false})
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
        obscureText: widget.hideText,
        controller: widget.textFieldController,
        style: GoogleFonts.poppins(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          // errorText: widget.showError ? 'This field can not be empty' : null,
          contentPadding: const EdgeInsets.only(top: 15),
          fillColor: const Color(0xffFAFAFA),
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

  validateTextField(text){
    if(text.length > 0){
      return null;
    }else{
      return 'This field can not be empty';
    }
  }
}
