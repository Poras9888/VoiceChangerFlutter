import 'package:flutter/material.dart';

class GradientHeroCard extends StatelessWidget {
  const GradientHeroCard({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A90E2), Color(0xFF5BA3F5)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Prank Sound',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text('Let the Prank Begin.', style: TextStyle(fontSize: 13, color: Color(0xBFFFFFFF))),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: onStart,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                ),
                child: const Text('Start'),
              ),
            ],
          ),
          const Positioned(right: 0, top: 0, child: Text('😈', style: TextStyle(fontSize: 120))),
        ],
      ),
    );
  }
}
