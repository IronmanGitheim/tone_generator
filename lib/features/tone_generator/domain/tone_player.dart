/// Contract for something that can produce a continuous, retunable tone.
///
/// Kept as an abstract interface (rather than depending on the concrete
/// audio engine directly) so the presentation layer can be tested without
/// touching real audio hardware/native bindings.
abstract class TonePlayer {
  /// Starts a continuous tone at [frequencyHz]. If already playing, this is
  /// a no-op (use [setFrequency] to retune a playing tone).
  Future<void> play(double frequencyHz);

  /// Stops the tone, if it is currently playing.
  Future<void> stop();

  /// Retunes the tone to [frequencyHz] live, without interrupting playback.
  /// Has no audible effect if the tone isn't currently playing.
  void setFrequency(double frequencyHz);

  /// Releases any underlying audio engine resources. Call when the player
  /// is no longer needed.
  Future<void> dispose();
}
