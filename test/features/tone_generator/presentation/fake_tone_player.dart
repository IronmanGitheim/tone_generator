import 'package:tone_generator/features/tone_generator/domain/tone_player.dart';

/// A [TonePlayer] test double that records calls instead of touching real
/// audio hardware/native bindings.
class FakeTonePlayer implements TonePlayer {
  int playCallCount = 0;
  int stopCallCount = 0;
  int disposeCallCount = 0;
  double? lastPlayedFrequencyHz;
  double? lastSetFrequencyHz;

  @override
  Future<void> play(double frequencyHz) async {
    playCallCount++;
    lastPlayedFrequencyHz = frequencyHz;
  }

  @override
  Future<void> stop() async {
    stopCallCount++;
  }

  @override
  void setFrequency(double frequencyHz) {
    lastSetFrequencyHz = frequencyHz;
  }

  @override
  Future<void> dispose() async {
    disposeCallCount++;
  }
}
