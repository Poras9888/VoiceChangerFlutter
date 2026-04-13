import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/usecases/convert_text_to_speech_usecase.dart';
import 'text_to_audio_state.dart';

class TextToAudioCubit extends Cubit<TextToAudioState> {
  TextToAudioCubit(this._convertUseCase) : super(const TextToAudioState());

  final ConvertTextToSpeechUseCase _convertUseCase;

  void updateText(String value) => emit(TextToAudioState(
        language: state.language,
        languageLabel: state.languageLabel,
        text: value,
        speed: state.speed,
        pitch: state.pitch,
        converted: state.converted,
        generatedPath: state.generatedPath,
      ));

  void setLanguage(String lang, String label) => emit(TextToAudioState(
        language: lang,
        languageLabel: label,
        text: state.text,
        speed: state.speed,
        pitch: state.pitch,
        converted: state.converted,
        generatedPath: state.generatedPath,
      ));

  void setSpeed(double value) => emit(TextToAudioState(
        language: state.language,
        languageLabel: state.languageLabel,
        text: state.text,
        speed: value,
        pitch: state.pitch,
        converted: state.converted,
        generatedPath: state.generatedPath,
      ));

  void setPitch(double value) => emit(TextToAudioState(
        language: state.language,
        languageLabel: state.languageLabel,
        text: state.text,
        speed: state.speed,
        pitch: value,
        converted: state.converted,
        generatedPath: state.generatedPath,
      ));

  Future<void> convertToSpeech() async {
    await _convertUseCase(
      text: state.text,
      language: state.language,
      speed: state.speed,
      pitch: state.pitch + 1,
    );
    emit(TextToAudioState(
      language: state.language,
      languageLabel: state.languageLabel,
      text: state.text,
      speed: state.speed,
      pitch: state.pitch,
      converted: true,
      generatedPath: state.generatedPath,
    ));
  }

  Future<void> playPreview() async {}
  Future<void> saveToLibrary() async {}

  Future<void> shareFile() async {
    if (state.generatedPath != null) {
      await Share.shareXFiles([XFile(state.generatedPath!)]);
    }
  }
}
