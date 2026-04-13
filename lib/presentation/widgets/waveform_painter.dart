import 'dart:ui';

import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  WaveformPainter(this.amplitudes);

  final List<double> amplitudes;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.85);
    final barCount = 40;
    final barWidth = size.width / (barCount * 1.5);

    for (var i = 0; i < barCount; i++) {
      final value = i < amplitudes.length ? amplitudes[i].clamp(0.0, 1.0) : 0.1;
      final smooth = lerpDouble(0.1, value, 0.8) ?? value;
      final height = smooth * size.height;
      final x = i * barWidth * 1.5;
      final rect = Rect.fromLTWH(x, (size.height - height) / 2, barWidth, height);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) => oldDelegate.amplitudes != amplitudes;
}
