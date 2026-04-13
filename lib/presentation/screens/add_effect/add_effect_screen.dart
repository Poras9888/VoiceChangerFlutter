import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/effect_card.dart';
import 'add_effect_cubit.dart';
import 'add_effect_state.dart';

class AddEffectScreen extends StatelessWidget {
  const AddEffectScreen({
    super.key,
    this.recordingPath,
    this.effectName,
  });

  final String? recordingPath;
  final String? effectName;

  static const allEffects = [
    ('Normal', '⭕', 'other'),
    ('Monster', '👹', 'scary'),
    ('Robot', '🤖', 'other'),
    ('Cave', '🗿', 'other'),
    ('Alien', '👽', 'other'),
    ('Nervous', '😰', 'other'),
    ('Death', '💀', 'scary'),
    ('Drunk', '🥴', 'other'),
    ('Underwater', '🌊', 'other'),
    ('Big Robot', '🦾', 'other'),
    ('Zombie', '🧟', 'scary'),
    ('Hexafluoride', '🎈', 'other'),
    ('Small Alien', '🛸', 'other'),
    ('Telephone', '📞', 'other'),
    ('Helium', '🎀', 'other'),
    ('Giant', '🗽', 'other'),
    ('Chipmunk', '🐿️', 'other'),
    ('Ghost', '👻', 'scary'),
    ('Darth Vader', '🪖', 'scary'),
    ('Reverse', '🔁', 'other'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEffectCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Effect')),
        body: BlocBuilder<AddEffectCubit, AddEffectState>(
          builder: (context, state) {
            final filtered = allEffects
                .where((e) => state.selectedCategory == 'all' || e.$3 == state.selectedCategory)
                .toList(growable: false);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A90E2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Icons.pause, color: Colors.white)),
                        const Text('00:04', style: TextStyle(color: Colors.white)),
                        Expanded(
                          child: Slider(
                            value: 0.35,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                            onChanged: (_) {},
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.volume_up, color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _chip(context, 'All Effects', 'all', state.selectedCategory),
                        _chip(context, 'Scary Effects', 'scary', state.selectedCategory),
                        _chip(context, 'Other Effects', 'other', state.selectedCategory),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      itemCount: filtered.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final effect = filtered[index];
                        return EffectCard(
                          emoji: effect.$2,
                          name: effect.$1,
                          selected: state.selectedEffect == effect.$1,
                          onTap: () => context.read<AddEffectCubit>().selectEffect(effect.$1),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label, String value, String selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: selected == value,
        label: Text(label),
        selectedColor: const Color(0xFF4A90E2),
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(color: selected == value ? Colors.white : Colors.black54),
        onSelected: (_) => context.read<AddEffectCubit>().filterByCategory(value),
      ),
    );
  }
}
