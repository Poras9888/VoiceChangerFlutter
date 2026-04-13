# Voice Changer & Sound Effects Recorder

Flutter app scaffold implementing a playful, emoji-centric voice changer for Android and iOS.

## Architecture
- Clean Architecture + BLoC/Cubit
- Navigation: GoRouter with custom transitions
- DI: get_it + injectable-ready bootstrap
- Data: Drift table definitions + repository layer
- Audio: record + just_audio + DSP effect pipeline stubs

## Setup
1. Install Flutter SDK.
2. Run `flutter pub get`.
3. Run `flutter pub run build_runner build --delete-conflicting-outputs`.
4. Run `flutter run`.

## Platform Requirements
- Android min SDK 24
- iOS platform 13.0
- Package: `com.voice.changer.sound.effects.recorder`

## Notes
- All audio files in `assets/audio/` are placeholders and should be replaced with real mp3 content.
- Drift generated files are intentionally lightweight in this scaffold and can be fully generated with build_runner.
