import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  Duration get position => _player.position;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Future<void> playFile(String path) async {
    await _player.setFilePath(path);
    await _player.play();
  }

  Future<void> playAsset(String assetPath) async {
    await _player.setAsset(assetPath);
    await _player.play();
  }

  Future<void> pause() => _player.pause();
  Future<void> stop() => _player.stop();
  Future<void> setVolume(double value) => _player.setVolume(value);
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> setLoop(bool enabled) =>
      _player.setLoopMode(enabled ? LoopMode.one : LoopMode.off);

  Future<void> dispose() => _player.dispose();
}
