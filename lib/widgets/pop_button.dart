import 'package:flutter/material.dart';

class PopButton extends StatefulWidget {
  const PopButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<PopButton> createState() => _PopButtonState();
}

class _PopButtonState extends State<PopButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      child: InkWell(
        onTap: widget.onTap,
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white.withOpacity(0.9),
            size: 30,
          ),
        ),
      ),
    );
  }
}

class backButton extends StatefulWidget {
  const backButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<backButton> createState() => _backButtonState();
}

class _backButtonState extends State<backButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        onTap: widget.onTap,
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white.withOpacity(0.9),
            size: 30,
          ),
        ),
      ),
    );
  }
}
