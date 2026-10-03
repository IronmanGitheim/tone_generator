import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import 'features/tone_generator/presentation/tone_generator_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Always (re)initialize the audio engine at startup. The native engine
  // survives a hot restart while the Dart side is reset, and init()
  // handles that by tearing down and re-creating the engine cleanly.
  await SoLoud.instance.init();
  runApp(const ProviderScope(child: ToneGeneratorApp()));
}

class ToneGeneratorApp extends StatelessWidget {
  const ToneGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tone Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ToneGeneratorScreen(),
    );
  }
}
