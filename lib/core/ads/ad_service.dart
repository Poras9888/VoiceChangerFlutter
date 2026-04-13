import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_ids.dart';

class AdService {
  BannerAd? _banner;
  InterstitialAd? _interstitial;
  String _bannerId = AdIds.banner;
  String _interstitialId = AdIds.interstitial;

  final ValueNotifier<BannerAd?> bannerNotifier = ValueNotifier<BannerAd?>(null);

  void setRemoteUnitIds({required String bannerId, required String interstitialId}) {
    if (bannerId.trim().isNotEmpty) {
      _bannerId = bannerId.trim();
    }
    if (interstitialId.trim().isNotEmpty) {
      _interstitialId = interstitialId.trim();
    }
  }

  Future<void> initialize({required bool canRequestAds}) async {
    await MobileAds.instance.initialize();
    if (!canRequestAds) {
      return;
    }
    await loadBanner();
    await loadInterstitial();
  }

  Future<void> loadBanner() async {
    _banner?.dispose();
    final banner = BannerAd(
      adUnitId: _bannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _banner = ad as BannerAd;
          bannerNotifier.value = _banner;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _banner = null;
          bannerNotifier.value = null;
        },
      ),
    );

    await banner.load();
  }

  Future<void> loadInterstitial() async {
    await InterstitialAd.load(
      adUnitId: _interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitial = ad;
        },
        onAdFailedToLoad: (_) {
          _interstitial = null;
        },
      ),
    );
  }

  Future<void> showInterstitialIfReady() async {
    final ad = _interstitial;
    if (ad == null) return;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitial = null;
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        _interstitial = null;
        loadInterstitial();
      },
    );

    ad.show();
    _interstitial = null;
  }

  void dispose() {
    _banner?.dispose();
    _interstitial?.dispose();
    bannerNotifier.dispose();
  }
}
