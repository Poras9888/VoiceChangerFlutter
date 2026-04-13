import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'effects/voice_effect.dart';

class AudioProcessor {
  Future<String> applyEffect(String inputPath, VoiceEffect effect) {
    return effect.process(inputPath);
  }

  static Future<String> staticProcess({
    required String inputPath,
    required String outputPath,
    required double pitchSemitones,
    required double speed,
    required double reverb,
    required double distortion,
    required double? ringModHz,
    required double? lowPassHz,
    required double? highPassHz,
    required bool reverse,
    required int? delayMs,
    required List<double>? dualRingHz,
  }) async {
    final inputFile = File(inputPath);
    final bytes = await inputFile.readAsBytes();
    final pcm = bytes.buffer.asInt16List();
    final out = List<double>.generate(pcm.length, (i) => pcm[i].toDouble());

    for (var i = 0; i < out.length; i++) {
      var sample = out[i] / 32768.0;
      if (ringModHz != null) {
        sample *= sin(2 * pi * ringModHz * i / 44100.0) * 0.8;
      }
      if (dualRingHz != null) {
        sample *=
            (sin(2 * pi * dualRingHz[0] * i / 44100.0) + sin(2 * pi * dualRingHz[1] * i / 44100.0)) * 0.4;
      }
      if (distortion > 0) {
        final k = 1 + distortion * 10;
        sample = tanh(k * sample);
      }
      if (reverb > 0 && i > 2205) {
        sample += out[i - 2205] / 32768.0 * reverb * 0.2;
      }
      if (delayMs != null) {
        final delaySamples = (44100 * (delayMs / 1000)).toInt();
        if (i > delaySamples) {
          sample += out[i - delaySamples] / 32768.0 * 0.3;
        }
      }
      out[i] = (sample.clamp(-1.0, 1.0) * 32767.0);
    }

    if (reverse) {
      out.reverse();
    }

    final pitched = _resample(out, pow(2, pitchSemitones / 12).toDouble() * speed);
    final int16 = Int16List.fromList(
      pitched.map((e) => e.round().clamp(-32768, 32767)).toList(),
    );
    await File(outputPath).writeAsBytes(int16.buffer.asUint8List());
    return outputPath;
  }

  static List<double> _resample(List<double> input, double ratio) {
    if (ratio == 1 || input.isEmpty) return input;
    final newLength = (input.length / ratio).round().clamp(1, input.length * 2);
    return List<double>.generate(newLength, (i) {
      final src = i * ratio;
      final i0 = src.floor().clamp(0, input.length - 1);
      final i1 = (i0 + 1).clamp(0, input.length - 1);
      final t = src - i0;
      return input[i0] * (1 - t) + input[i1] * t;
    });
  }
}
