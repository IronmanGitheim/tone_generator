import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:tone_generator/features/tone_generator/domain/frequency_mapper.dart';

void main() {
  group('FrequencyMapper.frequencyFromFraction', () {
    test('maps 0.0 to the minimum frequency', () {
      expect(
        FrequencyMapper.frequencyFromFraction(0),
        closeTo(FrequencyMapper.minFrequency, 1e-9),
      );
    });

    test('maps 1.0 to the maximum frequency', () {
      expect(
        FrequencyMapper.frequencyFromFraction(1),
        closeTo(FrequencyMapper.maxFrequency, 1e-9),
      );
    });

    test('is logarithmic: the midpoint fraction is the geometric mean', () {
      final geometricMean = math.sqrt(
        FrequencyMapper.minFrequency * FrequencyMapper.maxFrequency,
      );
      expect(
        FrequencyMapper.frequencyFromFraction(0.5),
        closeTo(geometricMean, 1e-6),
      );
    });

    test('a linear mapping would NOT put 0.5 at the geometric mean', () {
      // Regression guard for the log-mapping requirement: a naive linear
      // interpolation would put the midpoint at the arithmetic mean, which
      // is very different from the geometric mean for this range.
      final linearMidpoint =
          (FrequencyMapper.minFrequency + FrequencyMapper.maxFrequency) / 2;
      final logMidpoint = FrequencyMapper.frequencyFromFraction(0.5);
      expect((linearMidpoint - logMidpoint).abs(), greaterThan(1000));
    });

    test('clamps fractions outside [0.0, 1.0]', () {
      expect(
        FrequencyMapper.frequencyFromFraction(-1),
        FrequencyMapper.frequencyFromFraction(0),
      );
      expect(
        FrequencyMapper.frequencyFromFraction(2),
        FrequencyMapper.frequencyFromFraction(1),
      );
    });
  });

  group('FrequencyMapper.fractionFromFrequency', () {
    test('maps the minimum frequency to 0.0', () {
      expect(
        FrequencyMapper.fractionFromFrequency(FrequencyMapper.minFrequency),
        closeTo(0, 1e-9),
      );
    });

    test('maps the maximum frequency to 1.0', () {
      expect(
        FrequencyMapper.fractionFromFrequency(FrequencyMapper.maxFrequency),
        closeTo(1, 1e-9),
      );
    });

    test('clamps frequencies outside the valid range', () {
      expect(FrequencyMapper.fractionFromFrequency(1), closeTo(0, 1e-9));
      expect(FrequencyMapper.fractionFromFrequency(20000), closeTo(1, 1e-9));
    });

    test('round-trips with frequencyFromFraction', () {
      for (final fraction in [0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0]) {
        final frequency = FrequencyMapper.frequencyFromFraction(fraction);
        final roundTripped = FrequencyMapper.fractionFromFrequency(frequency);
        expect(roundTripped, closeTo(fraction, 1e-9));
      }
    });
  });
}
