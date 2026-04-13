import 'package:flutter/material.dart';

class RecordingListItem extends StatelessWidget {
  const RecordingListItem({
    super.key,
    required this.name,
    required this.effectAndDuration,
    required this.onPlay,
    this.onLongPress,
  });

  final String name;
  final String effectAndDuration;
  final VoidCallback onPlay;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onLongPress: onLongPress,
        leading: const Icon(Icons.graphic_eq, color: Color(0xFF4A90E2)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(effectAndDuration),
        trailing: IconButton(icon: const Icon(Icons.play_arrow), onPressed: onPlay),
      ),
    );
  }
}
