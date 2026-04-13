import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/recording_list_item.dart';
import 'saved_recordings_bloc.dart';
import 'saved_recordings_event.dart';
import 'saved_recordings_state.dart';

class SavedRecordingsScreen extends StatelessWidget {
  const SavedRecordingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SavedRecordingsBloc()..add(const LoadRecordings()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saved Recordings'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (v) => context.read<SavedRecordingsBloc>().add(SortRecordings(v)),
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'date', child: Text('Sort by Date')),
                PopupMenuItem(value: 'duration', child: Text('Sort by Duration')),
                PopupMenuItem(value: 'name', child: Text('Sort by Name')),
              ],
            ),
          ],
        ),
        body: BlocBuilder<SavedRecordingsBloc, SavedRecordingsState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.library_music_outlined, size: 64),
                    SizedBox(height: 8),
                    Text('No recordings yet', style: TextStyle(fontSize: 16)),
                    Text('Your processed voices will appear here', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return RecordingListItem(
                  name: item.fileName,
                  effectAndDuration: '${item.effectName} • ${item.duration}ms',
                  onPlay: () {},
                  onLongPress: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (_) => Wrap(
                      children: const [
                        ListTile(title: Text('Rename')),
                        ListTile(title: Text('Delete')),
                        ListTile(title: Text('Share')),
                        ListTile(title: Text('Set as Ringtone')),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
