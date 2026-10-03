import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:tone_generator/features/tone_generator/domain/wheel_angle.dart';

void main() {
  group('WheelAngle.angleFromOffset', () {
    test('top of the circle is angle 0', () {
      expect(
        WheelAngle.angleFromOffset(const Offset(0, -100)),
        closeTo(0, 1e-9),
      );
    });

    test('right of the circle is a quarter turn (pi/2)', () {
      expect(
        WheelAngle.angleFromOffset(const Offset(100, 0)),
        closeTo(math.pi / 2, 1e-9),
      );
    });

    test('bottom of the circle is a half turn (pi)', () {
      expect(
        WheelAngle.angleFromOffset(const Offset(0, 100)),
        closeTo(math.pi, 1e-9),
      );
    });

    test('left of the circle is three-quarters turn (3*pi/2)', () {
      expect(
        WheelAngle.angleFromOffset(const Offset(-100, 0)),
        closeTo(3 * math.pi / 2, 1e-9),
      );
    });

    test('is independent of radius (only angle matters)', () {
      final small = WheelAngle.angleFromOffset(const Offset(1, -1));
      final large = WheelAngle.angleFromOffset(const Offset(50, -50));
      expect(small, closeTo(large, 1e-9));
    });
  });

  group('WheelAngle.offsetFromAngle', () {
    test('is the inverse of angleFromOffset', () {
      for (final angle in [0.0, math.pi / 2, math.pi, 3 * math.pi / 2]) {
        final offset = WheelAngle.offsetFromAngle(angle, 100);
        final roundTripped = WheelAngle.angleFromOffset(offset);
        expect(roundTripped, closeTo(angle, 1e-9));
      }
    });
  });

  group('fractionFromAngle / angleFromFraction', () {
    test('round-trip for a range of fractions', () {
      for (final fraction in [0.0, 0.2, 0.5, 0.75, 0.99]) {
        final angle = WheelAngle.angleFromFraction(fraction);
        expect(WheelAngle.fractionFromAngle(angle), closeTo(fraction, 1e-9));
      }
    });

    test('a full turn (2*pi) is fraction 1.0', () {
      expect(WheelAngle.fractionFromAngle(2 * math.pi), closeTo(1, 1e-9));
    });
  });
}
