import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tone_generator/features/tone_generator/presentation/tone_generator_controller.dart';
import 'package:tone_generator/features/tone_generator/presentation/tone_generator_screen.dart';
import 'package:tone_generator/features/tone_generator/presentation/tone_player_provider.dart';
import 'package:tone_generator/features/tone_generator/presentation/tone_wheel.dart';

import 'fake_tone_player.dart';

void main() {
  testWidgets('tapping the wheel starts playback, tapping again stops it', (
    tester,
  ) async {
    final fakePlayer = FakeTonePlayer();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [tonePlayerProvider.overrideWith((ref) => fakePlayer)],
        child: const MaterialApp(home: ToneGeneratorScreen()),
      ),
    );

    // Starts stopped.
    expect(find.text('Stopped'), findsOneWidget);
    expect(find.text('Playing'), findsNothing);
    expect(fakePlayer.playCallCount, 0);

    // First tap starts playback.
    await tester.tap(find.byType(ToneWheel));
    await tester.pump();

    expect(find.text('Playing'), findsOneWidget);
    expect(find.text('Stopped'), findsNothing);
    expect(fakePlayer.playCallCount, 1);
    expect(fakePlayer.stopCallCount, 0);

    // Second tap stops playback.
    await tester.tap(find.byType(ToneWheel));
    await tester.pump();

    expect(find.text('Stopped'), findsOneWidget);
    expect(find.text('Playing'), findsNothing);
    expect(fakePlayer.playCallCount, 1);
    expect(fakePlayer.stopCallCount, 1);
  });

  testWidgets('play, retune and stop all reach the same player instance', (
    tester,
  ) async {
    // Build a fresh fake on every provider (re)creation, like the real
    // provider does, to catch the player being disposed between calls.
    final created = <FakeTonePlayer>[];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tonePlayerProvider.overrideWith((ref) {
            final player = FakeTonePlayer();
            created.add(player);
            return player;
          }),
        ],
        child: const MaterialApp(home: ToneGeneratorScreen()),
      ),
    );

    await tester.tap(find.byType(ToneWheel));
    await tester.pump();

    final center = tester.getCenter(find.byType(ToneWheel));
    await tester.dragFrom(center, const Offset(100, 0));
    await tester.pump();

    await tester.tap(find.byType(ToneWheel));
    await tester.pump();

    expect(created, hasLength(1));
    final player = created.single;
    expect(player.playCallCount, 1);
    expect(player.lastSetFrequencyHz, isNotNull);
    expect(player.stopCallCount, 1);
    expect(find.text('Stopped'), findsOneWidget);
  });

  testWidgets(
    'a mouse click that wobbles a few pixels still toggles playback',
    (tester) async {
      final fakePlayer = FakeTonePlayer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [tonePlayerProvider.overrideWith((ref) => fakePlayer)],
          child: const MaterialApp(home: ToneGeneratorScreen()),
        ),
      );

      final center = tester.getCenter(find.byType(ToneWheel));
      final gesture = await tester.startGesture(
        center,
        kind: PointerDeviceKind.mouse,
      );
      await gesture.moveBy(const Offset(4, 3));
      await gesture.up();
      await tester.pump();

      expect(fakePlayer.playCallCount, 1);
      expect(fakePlayer.lastPlayedFrequencyHz, 440);
      expect(find.text('Playing'), findsOneWidget);
    },
  );

  testWidgets('displays the default frequency numerically', (tester) async {
    final fakePlayer = FakeTonePlayer();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [tonePlayerProvider.overrideWith((ref) => fakePlayer)],
        child: const MaterialApp(home: ToneGeneratorScreen()),
      ),
    );

    expect(find.textContaining('Hz'), findsOneWidget);
  });

  testWidgets(
    'dragging the wheel changes the displayed frequency without toggling '
    'playback',
    (tester) async {
      final fakePlayer = FakeTonePlayer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [tonePlayerProvider.overrideWith((ref) => fakePlayer)],
          child: const MaterialApp(home: ToneGeneratorScreen()),
        ),
      );

      final container = ProviderScope.containerOf(
        tester.element(find.byType(ToneWheel)),
      );
      final frequencyBefore = container
          .read(toneGeneratorControllerProvider)
          .frequencyHz;

      final center = tester.getCenter(find.byType(ToneWheel));
      await tester.dragFrom(center, const Offset(100, 0));
      await tester.pump();

      final frequencyAfter = container
          .read(toneGeneratorControllerProvider)
          .frequencyHz;

      expect(frequencyAfter, isNot(closeTo(frequencyBefore, 0.001)));
      expect(fakePlayer.playCallCount, 0);
      expect(find.text('Stopped'), findsOneWidget);
    },
  );
}
