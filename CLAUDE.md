# Prosjektoversikt

Enkel Flutter-app under utvikling. Ingen ekstern backend i første omgang —
all data lagres lokalt på enheten. Fokus på enkelhet og ren kode fremfor
tidlig optimalisering.

Målplattformer: iOS og Android.

## Utviklingsmiljø

- Utvikles på **Windows** i VS Code med Claude Code-utvidelsen.
- iOS krever Xcode, som kun kjører på macOS. Under utvikling: test og
  iterer på **Android-emulator** lokalt. Bygg/test for iOS via en
  skytjeneste (f.eks. Codemagic) eller når Mac-tilgang er tilgjengelig.
- Kjør `flutter doctor` for å bekrefte at verktøykjeden er satt opp riktig.

## Teknisk stack

- **Framework:** Flutter (Dart)
- **State management:** Riverpod. Ikke bland inn andre løsninger
  (Provider, Bloc, GetX) — hold det konsekvent.
- **Lokal lagring:**
  - `shared_preferences` for enkle nøkkel/verdi-innstillinger
    (f.eks. brukervalg, tema, "har sett onboarding").
  - `hive` for strukturert data eller lister av objekter
    (f.eks. en liste med oppgaver, notater, favoritter).
  - Velg det enkleste alternativet som dekker behovet — ikke innfør
    en database før dataene faktisk krever det.
- **Backend:** Ingen. Ikke legg til nettverkskall, autentisering eller
  server-avhengigheter med mindre det blir eksplisitt bedt om.

## Mappestruktur

Feature-basert struktur. Hver funksjon samler sin egen kode fremfor å
spres på tvers av tekniske lag:

```
lib/
├── main.dart
├── features/
│   └── <feature_navn>/
│       ├── data/            # lagring/repositories for denne funksjonen
│       ├── domain/          # modeller og forretningslogikk
│       └── presentation/    # skjermer, widgets, Riverpod-providers
├── shared/
│   ├── widgets/             # gjenbrukbare widgets på tvers av features
│   └── utils/
└── core/
    ├── theme/
    └── constants/
```

## Kodekonvensjoner

- Følg standard Dart style guide. Kjør `dart format .` før commit.
- Kjør `flutter analyze` og fiks advarsler før commit.
- Filnavn: `snake_case.dart`. Klassenavn: `PascalCase`.
- Foretrekk `@riverpod`-kodegenerering (riverpod_generator) fremfor
  manuelt skrevne providers der det er praktisk.
- Skriv små, fokuserte widgets. Splitt opp filer som blir for lange.

## Vanlige kommandoer

| Kommando | Beskrivelse |
|---|---|
| `flutter pub get` | Installer avhengigheter |
| `flutter run` | Kjør appen på valgt enhet/emulator |
| `flutter test` | Kjør tester |
| `flutter analyze` | Statisk kodeanalyse |
| `dart format .` | Formater all kode |
| `flutter build apk` | Bygg Android-app |
| `flutter build ios` | Bygg iOS-app (krever Mac/skytjeneste) |

## Testing

- Unit-tester for forretningslogikk og Riverpod-providers.
- Widget-tester for UI-komponenter.
- Tester ligger i `test/` og speiler mappestrukturen i `lib/`.

## Notater til Claude

- Prosjektet er i en tidlig, enkel fase. Foreslå den enkleste løsningen
  som løser problemet — ikke overengineer eller innfør arkitektur/pakker
  appen ikke trenger ennå.
- Ikke legg til nye avhengigheter i `pubspec.yaml` uten å spørre først.
- Ikke anta at det finnes en backend eller nettverkstilgang.
- Hold deg til Riverpod for all state management.
- Når du foreslår kode som skal kjøre på iOS spesifikt, husk at det ikke
  kan testes lokalt på denne maskinen (Windows) — flagg dette hvis det
  er relevant.
