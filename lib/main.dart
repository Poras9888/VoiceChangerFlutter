import 'package:flutter/material.dart';

import 'app.dart';
import 'core/ads/ad_service.dart';
import 'core/ads/consent_manager.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final consentManager = getIt<ConsentManager>();
  await consentManager.gatherConsent();
  await getIt<AdService>().initialize(canRequestAds: consentManager.canRequestAds);

  runApp(const VoiceChangerApp());
}
