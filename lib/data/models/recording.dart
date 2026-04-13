import 'package:equatable/equatable.dart';

class RecordingModel extends Equatable {
  const RecordingModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.duration,
    required this.effectName,
    required this.createdAt,
    this.isFavorite = false,
  });

  final String id;
  final String fileName;
  final String filePath;
  final int duration;
  final String effectName;
  final int createdAt;
  final bool isFavorite;

  @override
  List<Object?> get props =>
      [id, fileName, filePath, duration, effectName, createdAt, isFavorite];
}
