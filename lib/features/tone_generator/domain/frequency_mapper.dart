import 'dart:math' as math;

/// Maps between a linear "wheel fraction" (0.0..1.0, one full turn of the
/// dial) and a frequency in Hz, using a logarithmic scale.
///
/// A logarithmic mapping is used because pitch perception is logarithmic:
/// a linear Hz mapping would waste almost the entire wheel on the top
/// octave (e.g. 7000-14000 Hz) while cramming every audible bass note into
/// a sliver of the dial.
class FrequencyMapper {
  const FrequencyMapper._();

  /// Lower bound of the tone generator's range, in Hz.
  static const double minFrequency = 20;

  /// Upper bound of the tone generator's range, in Hz.
  static const double maxFrequency = 14000;

  static final double _logRange = math.log(maxFrequency / minFrequency);

  /// Converts a wheel fraction in `[0.0, 1.0]` to a frequency in Hz.
  ///
  /// `fraction` is clamped to `[0.0, 1.0]` first, so callers don't need to
  /// pre-clamp values coming from raw drag/angle math.
  static double frequencyFromFraction(double fraction) {
    final clamped = clampFraction(fraction);
    return minFrequency * math.exp(_logRange * clamped);
  }

  /// Converts a frequency in Hz to a wheel fraction in `[0.0, 1.0]`.
  ///
  /// `frequencyHz` is clamped to `[minFrequency, maxFrequency]` first.
  static double fractionFromFrequency(double frequencyHz) {
    final clamped = clampFrequency(frequencyHz);
    return math.log(clamped / minFrequency) / _logRange;
  }

  /// Clamps a wheel fraction to the valid `[0.0, 1.0]` range.
  static double clampFraction(double fraction) => fraction.clamp(0.0, 1.0);

  /// Clamps a frequency to the valid `[minFrequency, maxFrequency]` range.
  static double clampFrequency(double frequencyHz) =>
      frequencyHz.clamp(minFrequency, maxFrequency);
}
