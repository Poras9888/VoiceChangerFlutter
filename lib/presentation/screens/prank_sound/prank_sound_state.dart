import 'package:equatable/equatable.dart';

class PrankSoundState extends Equatable {
  const PrankSoundState({
    this.volume = 1,
    this.loop = false,
    this.delay = 0,
    this.hiddenMode = false,
  });

  final double volume;
  final bool loop;
  final int delay;
  final bool hiddenMode;

  @override
  List<Object?> get props => [volume, loop, delay, hiddenMode];
}
