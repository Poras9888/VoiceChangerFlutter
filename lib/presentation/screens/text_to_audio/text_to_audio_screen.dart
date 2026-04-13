import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/usecases/convert_text_to_speech_usecase.dart';
import '../../widgets/waveform_painter.dart';
import 'text_to_audio_cubit.dart';
import 'text_to_audio_state.dart';

class TextToAudioScreen extends StatelessWidget {
  const TextToAudioScreen({super.key, this.generatedPath});

  final String? generatedPath;

  static const languages = [
    ('English 🇬🇧', 'en-GB'),
    ('Spanish 🇪🇸', 'es-ES'),
    ('French 🇫🇷', 'fr-FR'),
    ('German 🇩🇪', 'de-DE'),
    ('Italian 🇮🇹', 'it-IT'),
    ('Portuguese 🇵🇹', 'pt-PT'),
    ('Russian 🇷🇺', 'ru-RU'),
    ('Chinese 🇨🇳', 'zh-CN'),
    ('Japanese 🇯🇵', 'ja-JP'),
    ('Korean 🇰🇷', 'ko-KR'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TextToAudioCubit(ConvertTextToSpeechUseCase()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Text To Audio')),
        body: BlocBuilder<TextToAudioCubit, TextToAudioState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                InkWell(
                  onTap: () => _showLanguageDialog(context),
                  child: Card(
                    child: ListTile(
                      leading: const Text('🌐', style: TextStyle(fontSize: 24)),
                      title: Text(state.languageLabel),
                      trailing: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        TextField(
                          maxLength: AppConstants.maxTtsChars,
                          maxLines: 5,
                          decoration: const InputDecoration(hintText: 'Type something…'),
                          onChanged: (v) => context.read<TextToAudioCubit>().updateText(v),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('${state.text.length}/${AppConstants.maxTtsChars}', style: const TextStyle(color: Color(0xFF4A90E2))),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text('Speed'),
                    Expanded(
                      child: Slider(
                        min: 0.5,
                        max: 2.0,
                        divisions: 15,
                        value: state.speed,
                        onChanged: (v) => context.read<TextToAudioCubit>().setSpeed(v),
                      ),
                    ),
                    Text(state.speed.toStringAsFixed(1)),
                  ],
                ),
                Row(
                  children: [
                    const Text('Pitch'),
                    Expanded(
                      child: Slider(
                        min: -5,
                        max: 5,
                        divisions: 10,
                        value: state.pitch,
                        onChanged: (v) => context.read<TextToAudioCubit>().setPitch(v),
                      ),
                    ),
                    Text(state.pitch.toStringAsFixed(1)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => context.read<TextToAudioCubit>().convertToSpeech(),
                  icon: const Icon(Icons.mic),
                  label: const Text('Convert to Speech'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: const Color(0xFF4A90E2),
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                if (state.converted)
                  SizedBox(
                    height: 90,
                    child: CustomPaint(
                      painter: WaveformPainter(List<double>.generate(40, (i) => 0.2 + (i % 6) * 0.12)),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: () => context.read<TextToAudioCubit>().playPreview(), child: const Text('Play'))),
                    const SizedBox(width: 8),
                    Expanded(child: OutlinedButton(onPressed: () => context.read<TextToAudioCubit>().saveToLibrary(), child: const Text('Save'))),
                    const SizedBox(width: 8),
                    Expanded(child: OutlinedButton(onPressed: () => context.read<TextToAudioCubit>().shareFile(), child: const Text('Share'))),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select language'),
        content: SizedBox(
          width: 320,
          child: ListView(
            shrinkWrap: true,
            children: languages
                .map(
                  (e) => ListTile(
                    leading: const Text('🏳️'),
                    title: Text(e.$1),
                    onTap: () {
                      context.read<TextToAudioCubit>().setLanguage(e.$2, e.$1);
                      Navigator.of(context).pop();
                    },
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}
