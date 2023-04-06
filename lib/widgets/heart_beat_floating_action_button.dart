import 'package:flutter/material.dart';
import 'dart:math';

class HeartbeatFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;

  const HeartbeatFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  State<HeartbeatFloatingActionButton> createState() =>
      _HeartbeatFloatingActionButtonState();
}

class _HeartbeatFloatingActionButtonState
    extends State<HeartbeatFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
    });
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 54.0,
              height: 54.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return CustomPaint(
                    painter: RipplePainter(_animation.value),
                  );
                },
              ),
            ),
            Positioned(
              child: Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class RipplePainter extends CustomPainter {
  final double animationValue;
  final int numberOfWaves = 3;
  final Color waveColor = Colors.teal.withOpacity(0.2);
  final double waveWidth = 2.0;

  RipplePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = waveWidth;

    double radius =
        min(size.width / 2, size.height / 2) - waveWidth * numberOfWaves;

    for (int i = 1; i <= numberOfWaves; i++) {
      double waveRadius =
          radius + waveWidth * i + (animationValue * radius * 0.7);
      int alpha = (255 - (255 * animationValue)).round();
      paint.color = waveColor.withOpacity(alpha / 255);
      canvas.drawCircle(size.center(Offset.zero), waveRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
