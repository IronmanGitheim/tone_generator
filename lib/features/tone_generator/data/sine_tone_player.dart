import 'package:flutter_soloud/flutter_soloud.dart';

import '../domain/tone_player.dart';

/// A [TonePlayer] backed by `flutter_soloud`, generating a sine wave
/// procedurally (no audio asset files involved) so it can be retuned live
/// while playing.
class SineTonePlayer implements TonePlayer {
  AudioSource? _source;
  SoundHandle? _handle;

  final SoLoud _soloud = SoLoud.instance;

  Future<AudioSource> _ensureSource() async {
    final existing = _source;
    if (existing != null) {
      return existing;
    }
    // SoLoud is normally initialized once in main(); this is only a
    // fallback in case the player is used without that.
    if (!_soloud.isInitialized) {
      await _soloud.init();
    }
    final source = await _soloud.loadWaveform(WaveForm.sin, false, 0, 0);
    _source = source;
    return source;
  }

  @override
  Future<void> play(double frequencyHz) async {
    if (_handle != null) {
      // Already playing: retune instead of starting a second voice.
      setFrequency(frequencyHz);
      return;
    }
    final source = await _ensureSource();
    _soloud.setWaveformFreq(source, frequencyHz);
    _handle = await _soloud.play(source, looping: true);
  }

  @override
  Future<void> stop() async {
    final handle = _handle;
    if (handle == null) {
      return;
    }
    _handle = null;
    await _soloud.stop(handle);
  }

  @override
  void setFrequency(double frequencyHz) {
    final source = _source;
    if (source == null) {
      return;
    }
    _soloud.setWaveformFreq(source, frequencyHz);
  }

  @override
  Future<void> dispose() async {
    await stop();
    final source = _source;
    _source = null;
    if (source != null) {
      await _soloud.disposeSource(source);
    }
  }
}
