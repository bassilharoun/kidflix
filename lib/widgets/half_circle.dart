import 'dart:math' as math;
import 'package:flutter/material.dart';

class HalfCircle extends StatelessWidget {
  final double height;

  const HalfCircle({super.key, this.height = 100});

  @override
  Widget build(BuildContext context) {
    // Get the full width of the parent
    final width = MediaQuery.of(context).size.width;

    return CustomPaint(
      painter: MyPainter(),
      size: Size(width,
          height), // Set the size based on the desired height of the half-circle
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw only the half-circle within the specified size
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      math.pi, // Start angle
      math.pi, // Sweep angle (half-circle)
      true, // Use the fill mode
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
