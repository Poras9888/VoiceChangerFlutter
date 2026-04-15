import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AudioVisualizerWidget extends StatefulWidget {
  const AudioVisualizerWidget({super.key, this.height = 80});

  final double height;

  @override
  State<AudioVisualizerWidget> createState() => _AudioVisualizerWidgetState();
}

class _AudioVisualizerWidgetState extends State<AudioVisualizerWidget>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _random = Random();
  List<double> _bars = List<double>.filled(24, 0.2);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      setState(() {
        _bars = List<double>.generate(24, (_) => 0.15 + _random.nextDouble() * 0.85);
      });
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CustomPaint(
        painter: _FreqPainter(_bars),
        size: Size.infinite,
      ),
    );
  }
}

class _FreqPainter extends CustomPainter {
  _FreqPainter(this.bars);

  final List<double> bars;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF4A90E2);
    final width = size.width / (bars.length * 1.4);
    for (var i = 0; i < bars.length; i++) {
      final h = size.height * bars[i];
      final x = i * width * 1.4;
      final rect = Rect.fromLTWH(x, size.height - h, width, h);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(6)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FreqPainter oldDelegate) => oldDelegate.bars != bars;
}
