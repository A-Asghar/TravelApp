import 'package:flutter/material.dart';

errorSnackBar(BuildContext context, error) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
    ),
  );
}