import 'package:flutter/material.dart';

class CircularProgressButton extends StatefulWidget {
  const CircularProgressButton({
    super.key,
    required this.icon,
    required this.progressColor,
    this.strokeWidth = 4,
    this.onPressed,
  });

  final Widget icon;
  final Color progressColor;
  final double strokeWidth;
  final VoidCallback? onPressed;

  @override
  State<CircularProgressButton> createState() => _CircularProgressButtonState();
}

class _CircularProgressButtonState extends State<CircularProgressButton> {
  double _progress = 0;

  void setProgress(double value) {
    setState(() => _progress = value.clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size.square(72),
              painter: _ArcPainter(
                progress: _progress,
                color: widget.progressColor,
                strokeWidth: widget.strokeWidth,
              ),
            ),
            widget.icon,
          ],
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  const _ArcPainter({required this.progress, required this.color, required this.strokeWidth});

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTWH(4, 4, size.width - 8, size.height - 8),
      -1.5708,
      6.2831 * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) => oldDelegate.progress != progress;
}
