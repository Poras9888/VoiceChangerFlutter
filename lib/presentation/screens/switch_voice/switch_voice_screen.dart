import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'switch_voice_cubit.dart';

class SwitchVoiceScreen extends StatelessWidget {
  const SwitchVoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SwitchVoiceCubit(),
      child: const Scaffold(
        body: Center(child: Text('Switch Voice Ready 🔀')),
      ),
    );
  }
}
