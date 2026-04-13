import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../audio/audio_recorder.dart';
import '../../../audio/waveform_visualizer.dart';
import '../../../core/utils/permission_utils.dart';
import '../../widgets/waveform_painter.dart';
import 'recording_cubit.dart';
import 'recording_state.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key, this.audioPath});

  final String? audioPath;

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> with TickerProviderStateMixin {
  late final AnimationController _noteController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _noteController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))..repeat(reverse: true);
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final ms = ((d.inMilliseconds.remainder(1000)) ~/ 10).toString().padLeft(2, '0');
    return '$m:$s:$ms';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordingCubit(AudioRecorderService(), WaveformVisualizer()),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF3D82D6), Color(0xFF5BA8F5)]),
          ),
          child: SafeArea(
            child: BlocBuilder<RecordingCubit, RecordingState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    ...List.generate(3, (i) {
                      return Positioned(
                        left: 40.0 + i * 90,
                        top: 220 + sin((_noteController.value + i * 0.35) * pi) * 30,
                        child: const Text('♪', style: TextStyle(color: Colors.white70, fontSize: 28)),
                      );
                    }),
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        const Text('Recording', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomPaint(
                              painter: WaveformPainter(state.amplitudes.isEmpty ? List.filled(40, 0.1) : state.amplitudes),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        FadeTransition(
                          opacity: Tween<double>(begin: 1, end: 0.5).animate(_pulseController),
                          child: Text(
                            _fmt(state.elapsed),
                            style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 52,
                              height: 52,
                              child: FloatingActionButton(
                                heroTag: 'save',
                                backgroundColor: Colors.white70,
                                onPressed: () => context.read<RecordingCubit>().saveAndApplyEffect(),
                                child: const Icon(Icons.check, color: Colors.black87),
                              ),
                            ),
                            const SizedBox(width: 18),
                            SizedBox(
                              width: 68,
                              height: 68,
                              child: FloatingActionButton(
                                heroTag: 'stop',
                                backgroundColor: Colors.white,
                                onPressed: () async {
                                  if (!state.isRecording) {
                                    final ok = await PermissionUtils.requestMicrophone();
                                    if (!ok || !context.mounted) return;
                                    await context.read<RecordingCubit>().startRecording();
                                  } else {
                                    await context.read<RecordingCubit>().stopRecording();
                                  }
                                },
                                child: Icon(state.isRecording ? Icons.stop : Icons.mic, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
