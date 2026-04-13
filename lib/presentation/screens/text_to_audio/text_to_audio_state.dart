import 'package:equatable/equatable.dart';

class TextToAudioState extends Equatable {
  const TextToAudioState({
    this.language = 'en-GB',
    this.languageLabel = 'English 🇬🇧',
    this.text = '',
    this.speed = 1,
    this.pitch = 0,
    this.converted = false,
    this.generatedPath,
  });

  final String language;
  final String languageLabel;
  final String text;
  final double speed;
  final double pitch;
  final bool converted;
  final String? generatedPath;

  @override
  List<Object?> get props => [language, languageLabel, text, speed, pitch, converted, generatedPath];
}
