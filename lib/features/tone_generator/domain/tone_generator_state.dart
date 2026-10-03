import 'package:flutter/foundation.dart';

/// Immutable state for the tone generator: the currently selected
/// frequency and whether the tone is currently sounding.
@immutable
class ToneGeneratorState {
  const ToneGeneratorState({
    required this.frequencyHz,
    required this.isPlaying,
  });

  final double frequencyHz;
  final bool isPlaying;

  ToneGeneratorState copyWith({double? frequencyHz, bool? isPlaying}) {
    return ToneGeneratorState(
      frequencyHz: frequencyHz ?? this.frequencyHz,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ToneGeneratorState &&
        other.frequencyHz == frequencyHz &&
        other.isPlaying == isPlaying;
  }

  @override
  int get hashCode => Object.hash(frequencyHz, isPlaying);

  @override
  String toString() =>
      'ToneGeneratorState(frequencyHz: $frequencyHz, isPlaying: $isPlaying)';
}
