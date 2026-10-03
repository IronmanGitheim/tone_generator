// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tone_generator_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the tone generator screen: holds the currently selected
/// frequency and playback state, and forwards changes to the underlying
/// [TonePlayer].

@ProviderFor(ToneGeneratorController)
final toneGeneratorControllerProvider = ToneGeneratorControllerProvider._();

/// Drives the tone generator screen: holds the currently selected
/// frequency and playback state, and forwards changes to the underlying
/// [TonePlayer].
final class ToneGeneratorControllerProvider
    extends $NotifierProvider<ToneGeneratorController, ToneGeneratorState> {
  /// Drives the tone generator screen: holds the currently selected
  /// frequency and playback state, and forwards changes to the underlying
  /// [TonePlayer].
  ToneGeneratorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toneGeneratorControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toneGeneratorControllerHash();

  @$internal
  @override
  ToneGeneratorController create() => ToneGeneratorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToneGeneratorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToneGeneratorState>(value),
    );
  }
}

String _$toneGeneratorControllerHash() =>
    r'f52541ff72df5e5db2bd38fca99685b65da24a58';

/// Drives the tone generator screen: holds the currently selected
/// frequency and playback state, and forwards changes to the underlying
/// [TonePlayer].

abstract class _$ToneGeneratorController extends $Notifier<ToneGeneratorState> {
  ToneGeneratorState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ToneGeneratorState, ToneGeneratorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ToneGeneratorState, ToneGeneratorState>,
              ToneGeneratorState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
