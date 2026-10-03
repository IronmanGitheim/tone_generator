// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tone_player_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [TonePlayer] used by the tone generator.
///
/// Kept behind a provider (rather than constructed inline in the
/// controller) so widget tests can override it with a fake and avoid
/// touching the real audio engine.

@ProviderFor(tonePlayer)
final tonePlayerProvider = TonePlayerProvider._();

/// Provides the [TonePlayer] used by the tone generator.
///
/// Kept behind a provider (rather than constructed inline in the
/// controller) so widget tests can override it with a fake and avoid
/// touching the real audio engine.

final class TonePlayerProvider
    extends $FunctionalProvider<TonePlayer, TonePlayer, TonePlayer>
    with $Provider<TonePlayer> {
  /// Provides the [TonePlayer] used by the tone generator.
  ///
  /// Kept behind a provider (rather than constructed inline in the
  /// controller) so widget tests can override it with a fake and avoid
  /// touching the real audio engine.
  TonePlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tonePlayerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tonePlayerHash();

  @$internal
  @override
  $ProviderElement<TonePlayer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TonePlayer create(Ref ref) {
    return tonePlayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TonePlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TonePlayer>(value),
    );
  }
}

String _$tonePlayerHash() => r'77b84869972db9a898c41fb53b2154346c9b3bdd';
