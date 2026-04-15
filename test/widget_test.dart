import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_changer_sound_effects_recorder/app.dart';

void main() {
  testWidgets('renders the app shell', (tester) async {
    await tester.pumpWidget(const VoiceChangerApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
