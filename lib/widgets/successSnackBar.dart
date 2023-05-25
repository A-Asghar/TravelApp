import 'package:flutter/material.dart';

successSnackBar(BuildContext context, error) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
      backgroundColor: Colors.teal,
      duration: const Duration(seconds: 5),
    ),
  );
}
