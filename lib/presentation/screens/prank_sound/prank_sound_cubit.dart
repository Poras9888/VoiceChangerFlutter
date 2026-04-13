import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:isolate';

import '../../../audio/audio_player.dart';
import 'prank_sound_state.dart';

class PrankSoundCubit extends Cubit<PrankSoundState> {
  PrankSoundCubit(this._player) : super(const PrankSoundState());

  final AudioPlayerService _player;

  Future<void> playSound(String asset) async {
    await _player.playAsset(asset);
  }

  Future<void> setVolume(double value) async {
    await _player.setVolume(value);
    emit(PrankSoundState(
      volume: value,
      loop: state.loop,
      delay: state.delay,
      hiddenMode: state.hiddenMode,
    ));
  }

  Future<void> setLoop(bool value) async {
    await _player.setLoop(value);
    emit(PrankSoundState(
      volume: state.volume,
      loop: value,
      delay: state.delay,
      hiddenMode: state.hiddenMode,
    ));
  }

  void setDelay(int value) {
    emit(PrankSoundState(
      volume: state.volume,
      loop: state.loop,
      delay: value,
      hiddenMode: state.hiddenMode,
    ));
  }

  Future<void> startHiddenMode() async {
    await Isolate.run(() {});
    emit(PrankSoundState(
      volume: state.volume,
      loop: state.loop,
      delay: state.delay,
      hiddenMode: true,
    ));
  }
}
