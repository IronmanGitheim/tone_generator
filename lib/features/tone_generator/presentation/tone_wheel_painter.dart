import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../domain/wheel_angle.dart';

/// Paints the circular dial: a track, a progress arc up to the current
/// wheel fraction, and a knob marking the selected position.
class ToneWheelPainter extends CustomPainter {
  const ToneWheelPainter({required this.fraction, required this.isPlaying});

  /// Current position on the dial, in `[0.0, 1.0]`.
  final double fraction;

  /// Whether a tone is currently sounding (changes the accent color).
  final bool isPlaying;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - _strokeWidth / 2;

    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final accentColor = isPlaying ? Colors.teal : Colors.blueGrey;

    final progressPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    final sweepAngle = WheelAngle.angleFromFraction(fraction);
    // Arcs are measured counter-clockwise-from-3-o'clock in Canvas terms,
    // so shift by -pi/2 to start at the top, matching WheelAngle's
    // clockwise-from-top convention.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    final knobOffset = center + WheelAngle.offsetFromAngle(sweepAngle, radius);
    final knobPaint = Paint()..color = accentColor;
    canvas.drawCircle(knobOffset, _knobRadius, knobPaint);
  }

  @override
  bool shouldRepaint(covariant ToneWheelPainter oldDelegate) {
    return oldDelegate.fraction != fraction ||
        oldDelegate.isPlaying != isPlaying;
  }

  static const double _strokeWidth = 10;
  static const double _knobRadius = 12;
}
