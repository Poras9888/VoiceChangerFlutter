import 'dart:async';

class ConsentManager {
  bool _canRequestAds = false;

  bool get canRequestAds => _canRequestAds;

  Future<void> gatherConsent() async {
    await Future<void>.delayed(Duration.zero);
    _canRequestAds = false;
  }

  Future<void> showPrivacyOptions() async {
    await Future<void>.delayed(Duration.zero);
  }
}
