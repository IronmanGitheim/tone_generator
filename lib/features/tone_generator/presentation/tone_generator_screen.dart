import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tone_generator_controller.dart';
import 'tone_wheel.dart';

/// The app's single screen: a wheel to pick/tune a frequency, plus a
/// readout of the current frequency and playback state.
class ToneGeneratorScreen extends ConsumerWidget {
  const ToneGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(toneGeneratorControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tone Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ToneWheel(),
            const SizedBox(height: 32),
            Text(
              '${state.frequencyHz.round()} Hz',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.isPlaying ? 'Playing' : 'Stopped',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: state.isPlaying ? Colors.teal : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
