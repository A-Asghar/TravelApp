import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String image;

  const FullScreenImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 5,
              child: Image.network(image),
            ),
          ),
        ),
      ),
    );
  }
}
