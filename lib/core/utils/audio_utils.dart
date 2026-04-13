import 'dart:math';

class AudioUtils {
  static List<double> normalizePcm16(List<int> samples) {
    if (samples.isEmpty) return const [];
    final maxAbs = samples.map((e) => e.abs()).fold<int>(1, max);
    return samples.map((s) => s / maxAbs).toList(growable: false);
  }
}
