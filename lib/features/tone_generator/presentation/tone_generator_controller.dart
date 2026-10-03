import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/frequency_mapper.dart';
import '../domain/tone_generator_state.dart';
import 'tone_player_provider.dart';

part 'tone_generator_controller.g.dart';

/// Default frequency the tone generator starts at (concert pitch A4),
/// comfortably inside the 20 Hz - 10 kHz range.
const double _defaultFrequencyHz = 440;

/// Drives the tone generator screen: holds the currently selected
/// frequency and playback state, and forwards changes to the underlying
/// [TonePlayer].
@riverpod
class ToneGeneratorController extends _$ToneGeneratorController {
  @override
  ToneGeneratorState build() {
    // tonePlayerProvider is auto-dispose: watching it here keeps the same
    // player instance alive for the controller's lifetime. Without this,
    // every ref.read below would get a fresh player, so stop() and
    // setFrequency() would never reach the voice that play() started.
    ref.watch(tonePlayerProvider);
    return const ToneGeneratorState(
      frequencyHz: _defaultFrequencyHz,
      isPlaying: false,
    );
  }

  /// Updates the selected frequency from a wheel fraction (`[0.0, 1.0]`,
  /// one full turn of the dial). If the tone is currently playing, it is
  /// retuned live.
  void setFrequencyFromWheelFraction(double fraction) {
    final frequencyHz = FrequencyMapper.frequencyFromFraction(fraction);
    state = state.copyWith(frequencyHz: frequencyHz);
    if (state.isPlaying) {
      ref.read(tonePlayerProvider).setFrequency(frequencyHz);
    }
  }

  /// Toggles playback: starts a continuous tone at the current frequency,
  /// or stops it if already playing.
  Future<void> toggle() async {
    // Ignore clicks that arrive while a previous play/stop is still in
    // flight, so a quick double click can't start two voices.
    if (_isToggling) {
      return;
    }
    _isToggling = true;
    final player = ref.read(tonePlayerProvider);
    try {
      if (state.isPlaying) {
        await player.stop();
        state = state.copyWith(isPlaying: false);
      } else {
        await player.play(state.frequencyHz);
        state = state.copyWith(isPlaying: true);
      }
    } catch (error, stackTrace) {
      // Surface audio engine failures in the console instead of letting
      // them vanish in an unawaited future.
      debugPrint('Tone generator toggle failed: $error\n$stackTrace');
    } finally {
      _isToggling = false;
    }
  }

  bool _isToggling = false;
}
