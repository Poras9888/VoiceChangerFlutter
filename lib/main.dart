import 'package:flutter/material.dart';

import 'app.dart';
import 'core/ads/ad_service.dart';
import 'core/ads/consent_manager.dart';
import 'core/ads/remote_ads_config_service.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final adService = getIt<AdService>();
  final remoteConfig = await getIt<RemoteAdsConfigService>().fetchRemoteConfig();
  if (remoteConfig != null) {
    adService.setRemoteUnitIds(
      bannerId: remoteConfig.bannerId,
      interstitialId: remoteConfig.interstitialId,
    );
  }

  final consentManager = getIt<ConsentManager>();
  await consentManager.gatherConsent();
  await adService.initialize(canRequestAds: consentManager.canRequestAds);

  runApp(const VoiceChangerApp());
}
