import 'package:flutter/material.dart';

successSnackBar(BuildContext context, text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.teal,
      duration: const Duration(seconds: 5),
    ),
  );
}