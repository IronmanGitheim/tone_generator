# Tone Generator

A simple Flutter app for playing a steady sine tone at a frequency you choose
with a rotary wheel. It is built as a tool to help find and match a tinnitus
tone.

> **Note:** This app is not a medical device and does not diagnose or treat
> tinnitus. Start at a low volume. Loud or high-pitched tones can be
> uncomfortable and may damage hearing.

## How to use

- **Click or tap the wheel** to start the tone. Click again to stop it.
- **Drag around the wheel** to change the frequency, from **20 Hz to
  14 000 Hz**. While the tone is playing, the pitch changes as you drag.
- The current frequency and whether the tone is playing are shown below the
  wheel. The app starts at 440 Hz (the note A4).

The wheel uses a logarithmic scale. Each part of the wheel covers the same
musical interval, so low and high tones are equally easy to adjust.

## Platforms

- **Android:** main target.
- **iOS:** planned, but not yet tested. Building for iOS needs a Mac or a
  cloud build service.
- **Windows desktop:** works and is used for local development.

All data stays on the device. The app has no backend and makes no network
calls.

## Getting started

Requirements: the [Flutter SDK](https://docs.flutter.dev/get-started/install).
Run `flutter doctor` to check your setup.

```sh
flutter pub get           # install dependencies
flutter run               # run on a connected device or emulator
flutter run -d windows    # run as a Windows desktop app
```

## Development

| Command | Description |
|---|---|
| `flutter test` | Run tests |
| `flutter analyze` | Static code analysis |
| `dart format .` | Format all code |
| `dart run build_runner build` | Regenerate Riverpod code (`*.g.dart`) |
| `flutter build apk` | Build the Android app |

### Tech stack

- [Flutter](https://flutter.dev) (Dart)
- [Riverpod](https://riverpod.dev) with code generation for state management
- [flutter_soloud](https://pub.dev/packages/flutter_soloud) for real-time
  sine wave synthesis. The tone is generated while the app runs, not loaded
  from audio files.

### Project structure

```
lib/
├── main.dart                          # app entry, starts the audio engine
└── features/tone_generator/
    ├── data/sine_tone_player.dart     # audio playback via flutter_soloud
    ├── domain/                        # frequency mapping, wheel geometry, state
    └── presentation/                  # screen, wheel widget, Riverpod providers
test/                                  # mirrors lib/
```
