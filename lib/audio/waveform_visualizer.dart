import 'dart:async';
import 'dart:math';

class WaveformVisualizer {
  final _amplitudeController = StreamController<double>.broadcast();
  final Random _random = Random();
  Timer? _timer;

  Stream<double> get amplitudeStream => _amplitudeController.stream;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      _amplitudeController.add(_random.nextDouble());
    });
  }

  void stop() {
    _timer?.cancel();
  }

  Future<void> dispose() async {
    _timer?.cancel();
    await _amplitudeController.close();
  }
}
