import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/add_effect/add_effect_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/prank_sound/prank_sound_screen.dart';
import '../../presentation/screens/recording/recording_screen.dart';
import '../../presentation/screens/reverse_voice/reverse_voice_screen.dart';
import '../../presentation/screens/saved_recordings/saved_recordings_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/switch_voice/switch_voice_screen.dart';
import '../../presentation/screens/text_to_audio/text_to_audio_screen.dart';

Page<void> _buildTransitionPage(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 300),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
          child: child,
        ),
      );
    },
  );
}

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', pageBuilder: (c, s) => _buildTransitionPage(const HomeScreen(), s)),
    GoRoute(
      path: '/recording',
      pageBuilder: (c, s) {
        final extra = (s.extra is Map) ? s.extra as Map : const {};
        return _buildTransitionPage(
          RecordingScreen(audioPath: extra['audioPath'] as String?),
          s,
        );
      },
    ),
    GoRoute(
      path: '/add-effect',
      pageBuilder: (c, s) {
        final extra = (s.extra is Map) ? s.extra as Map : const {};
        return _buildTransitionPage(
          AddEffectScreen(
            recordingPath: extra['recordingPath'] as String?,
            effectName: extra['effectName'] as String?,
          ),
          s,
        );
      },
    ),
    GoRoute(path: '/prank-sound', pageBuilder: (c, s) => _buildTransitionPage(const PrankSoundScreen(), s)),
    GoRoute(
      path: '/text-to-audio',
      pageBuilder: (c, s) {
        final extra = (s.extra is Map) ? s.extra as Map : const {};
        return _buildTransitionPage(
          TextToAudioScreen(generatedPath: extra['generatedPath'] as String?),
          s,
        );
      },
    ),
    GoRoute(path: '/reverse-voice', pageBuilder: (c, s) => _buildTransitionPage(const ReverseVoiceScreen(), s)),
    GoRoute(path: '/switch-voice', pageBuilder: (c, s) => _buildTransitionPage(const SwitchVoiceScreen(), s)),
    GoRoute(path: '/saved-recordings', pageBuilder: (c, s) => _buildTransitionPage(const SavedRecordingsScreen(), s)),
    GoRoute(path: '/settings', pageBuilder: (c, s) => _buildTransitionPage(const SettingsScreen(), s)),
  ],
);
