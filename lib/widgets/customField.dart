import 'package:flutter/material.dart';

import '../Constants.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController textFieldController;

  final Widget sufix;
  final TextInputType keyboardType;
  const CustomField(
      {Key? key,
      required this.hintText,
      required this.textFieldController,
      required this.sufix,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: textFieldController,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
            ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15, left: 16),
          fillColor: Constants.secondaryColor.withOpacity(0.05),
          filled: true,
          hintText: hintText,
          suffixIcon: sufix,
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
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: const Color(0xff9E9E9E),
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}
