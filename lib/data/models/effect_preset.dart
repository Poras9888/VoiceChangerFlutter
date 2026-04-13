import 'package:equatable/equatable.dart';

class EffectPresetModel extends Equatable {
  const EffectPresetModel({
    required this.id,
    required this.name,
    required this.category,
    required this.pitchShift,
    required this.speed,
    required this.reverb,
    required this.distortion,
    this.isUnlocked = true,
  });

  final String id;
  final String name;
  final String category;
  final double pitchShift;
  final double speed;
  final double reverb;
  final double distortion;
  final bool isUnlocked;

  @override
  List<Object?> get props =>
      [id, name, category, pitchShift, speed, reverb, distortion, isUnlocked];
}
