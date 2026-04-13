import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../audio/audio_player.dart';
import '../../widgets/prank_sound_card.dart';
import 'prank_sound_cubit.dart';
import 'prank_sound_state.dart';

class PrankSoundScreen extends StatefulWidget {
  const PrankSoundScreen({super.key});

  @override
  State<PrankSoundScreen> createState() => _PrankSoundScreenState();
}

class _PrankSoundScreenState extends State<PrankSoundScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const sounds = [
    ('😂', 'Funny', 'assets/audio/prank_funny_1.mp3'),
    ('⚙️', 'Engine', 'assets/audio/prank_engine_1.mp3'),
    ('💨', 'Fart', 'assets/audio/prank_fart_1.mp3'),
    ('🤧', 'Sneeze', 'assets/audio/prank_sneeze_1.mp3'),
    ('😴', 'Snore', 'assets/audio/prank_snore_1.mp3'),
    ('🍾', 'Breaking', 'assets/audio/prank_breaking_1.mp3'),
    ('🐕', 'Dog', 'assets/audio/animal_dog.mp3'),
    ('🐈', 'Cat', 'assets/audio/animal_cat.mp3'),
    ('🐄', 'Cow', 'assets/audio/animal_cow.mp3'),
    ('🦁', 'Lion', 'assets/audio/animal_lion.mp3'),
    ('🐯', 'Tiger', 'assets/audio/animal_tiger.mp3'),
    ('🐷', 'Pig', 'assets/audio/animal_pig.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrankSoundCubit(AudioPlayerService()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sound Prank')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF4A90E2), Color(0xFF5BA3F5)]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    _floatingEmoji('👻', Alignment.topLeft, 0.0),
                    _floatingEmoji('🔊', Alignment.center, 0.25),
                    _floatingEmoji('🤣', Alignment.bottomRight, 0.5),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: sounds.length,
                  itemBuilder: (context, index) {
                    final item = sounds[index];
                    return PrankSoundCard(
                      emoji: item.$1,
                      title: item.$2,
                      onTap: () => context.read<PrankSoundCubit>().playSound(item.$3),
                    );
                  },
                ),
              ),
              BlocBuilder<PrankSoundCubit, PrankSoundState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Slider(
                        value: state.volume,
                        onChanged: (v) => context.read<PrankSoundCubit>().setVolume(v),
                      ),
                      SwitchListTile(
                        title: const Text('Loop'),
                        value: state.loop,
                        onChanged: (v) => context.read<PrankSoundCubit>().setLoop(v),
                      ),
                      DropdownButton<int>(
                        value: state.delay,
                        items: const [0, 5, 10, 30]
                            .map((e) => DropdownMenuItem(value: e, child: Text('${e}s')))
                            .toList(growable: false),
                        onChanged: (v) => context.read<PrankSoundCubit>().setDelay(v ?? 0),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<PrankSoundCubit>().startHiddenMode(),
                        child: Text(state.hiddenMode ? 'Hidden Mode Active' : 'Hidden Mode'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingEmoji(String emoji, Alignment alignment, double phase) {
    return Align(
      alignment: alignment,
      child: SlideTransition(
        position: Tween(begin: Offset.zero, end: const Offset(0, -0.08)).animate(
          CurvedAnimation(parent: _controller, curve: Interval(phase, 1, curve: Curves.easeInOut)),
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 38)),
      ),
    );
  }
}
