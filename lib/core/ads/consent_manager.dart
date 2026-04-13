import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentManager {
  bool _canRequestAds = false;

  bool get canRequestAds => _canRequestAds;

  Future<void> gatherConsent() async {
    final completer = Completer<void>();
    final params = ConsentRequestParameters();

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        try {
          await UserMessagingPlatform.loadAndShowConsentFormIfRequired((_) {});
          final dynamic consentInfo = ConsentInformation.instance;
          final dynamic canRequest = consentInfo.canRequestAds();
          if (canRequest is Future<bool>) {
            _canRequestAds = await canRequest;
          } else if (canRequest is bool) {
            _canRequestAds = canRequest;
          }
        } catch (_) {
          _canRequestAds = false;
        } finally {
          if (!completer.isCompleted) {
            completer.complete();
          }
        }
      },
      (_) {
        _canRequestAds = false;
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
    );

    await completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        _canRequestAds = false;
      },
    );
  }

  Future<void> showPrivacyOptions() async {
    try {
      await UserMessagingPlatform.showPrivacyOptionsForm((_) {});
    } catch (_) {
      // Ignore when privacy options are not required for current region.
    }
  }
}
