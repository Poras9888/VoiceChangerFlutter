import 'ad_ids.dart';

class AdService {
  String _bannerId = AdIds.banner;
  String _interstitialId = AdIds.interstitial;

  bool get hasBanner => false;

  void setRemoteUnitIds({required String bannerId, required String interstitialId}) {
    if (bannerId.trim().isNotEmpty) {
      _bannerId = bannerId.trim();
    }
    if (interstitialId.trim().isNotEmpty) {
      _interstitialId = interstitialId.trim();
    }
  }

  Future<void> initialize({required bool canRequestAds}) async {
  }

  Future<void> loadBanner() async {
  }

  Future<void> loadInterstitial() async {
  }

  Future<void> showInterstitialIfReady() async {
  }

  void dispose() {
  }
}
