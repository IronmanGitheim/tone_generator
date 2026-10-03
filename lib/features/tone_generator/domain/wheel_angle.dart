import 'dart:math' as math;
import 'dart:ui' show Offset;

/// Pure geometry helpers for the circular wheel control.
///
/// Angles are measured in radians, clockwise, starting at the top of the
/// circle (12 o'clock = angle 0), and normalized to `[0, 2*pi)`.
class WheelAngle {
  const WheelAngle._();

  static const double fullTurn = 2 * math.pi;

  /// Computes the clockwise-from-top angle of [offsetFromCenter], i.e. a
  /// drag/tap position expressed relative to the wheel's center.
  static double angleFromOffset(Offset offsetFromCenter) {
    final angle = math.atan2(offsetFromCenter.dx, -offsetFromCenter.dy);
    return angle < 0 ? angle + fullTurn : angle;
  }

  /// The inverse of [angleFromOffset]: given an [angle] and a [radius],
  /// returns the offset (relative to the wheel's center) that lies on the
  /// circle of that radius at that angle.
  static Offset offsetFromAngle(double angle, double radius) {
    return Offset(radius * math.sin(angle), -radius * math.cos(angle));
  }

  /// Converts an angle in `[0, 2*pi)` to a wheel fraction in `[0.0, 1.0]`.
  static double fractionFromAngle(double angle) => angle / fullTurn;

  /// Converts a wheel fraction in `[0.0, 1.0]` to an angle in `[0, 2*pi)`.
  static double angleFromFraction(double fraction) => fraction * fullTurn;
}
