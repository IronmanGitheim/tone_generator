import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/sine_tone_player.dart';
import '../domain/tone_player.dart';

part 'tone_player_provider.g.dart';

/// Provides the [TonePlayer] used by the tone generator.
///
/// Kept behind a provider (rather than constructed inline in the
/// controller) so widget tests can override it with a fake and avoid
/// touching the real audio engine.
@riverpod
TonePlayer tonePlayer(Ref ref) {
  final player = SineTonePlayer();
  ref.onDispose(() {
    // Fire and forget: dispose is async, but ref.onDispose callbacks are
    // synchronous. Errors are swallowed here since there's nothing
    // meaningful to do with them during teardown.
    unawaited(player.dispose());
  });
  return player;
}
