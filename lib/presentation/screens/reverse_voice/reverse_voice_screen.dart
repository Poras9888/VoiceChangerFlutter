import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reverse_voice_cubit.dart';

class ReverseVoiceScreen extends StatelessWidget {
  const ReverseVoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReverseVoiceCubit(),
      child: const Scaffold(
        body: Center(child: Text('Reverse Voice Ready 🔁')),
      ),
    );
  }
}
