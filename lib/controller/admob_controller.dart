import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get bannerAdUnitId1 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978112';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_BANNER_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

class AdState {
  final BannerAd? bannerAd;
  final InterstitialAd? interstitialAd;
  final RewardedAd? rewardedAd;

  AdState(
      {required this.bannerAd,
      required this.interstitialAd,
      required this.rewardedAd});

  AdState copyWith({
    BannerAd? bannerAd,
    InterstitialAd? interstitialAd,
    RewardedAd? rewardedAd,
  }) {
    return AdState(
        bannerAd: bannerAd ?? this.bannerAd,
        interstitialAd: interstitialAd ?? this.interstitialAd,
        rewardedAd: rewardedAd ?? this.rewardedAd);
  }
}

class AdmobController extends StateNotifier<AdState> {
  AdmobController()
      : super(AdState(
          bannerAd: null,
          interstitialAd: null,
          rewardedAd: null,
        ));

  Future<void> loadBannerAd() async {
    return BannerAd(
      adUnitId: AdHelper.bannerAdUnitId1,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          state = state.copyWith(bannerAd: ad as BannerAd);
        },
        onAdLoaded: (ad) {
          state = state.copyWith(bannerAd: ad as BannerAd);
        },
      ),
    ).load();
  }

/*   void disposeBannerAd() {
    state.bannerAd?.dispose();
    state = state.copyWith(bannerAd: null);
  } */

  // ---------------------------------------------------------------------------
  Future<void> loadInterstitialAd() {
    return InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) async {
              // ad.dispose();
              await loadInterstitialAd();
            },
          );
          state = state.copyWith(interstitialAd: ad);
        },
        onAdFailedToLoad: (err) {},
      ),
    );
  }

  // ---------------------------------------------------------------------------
  Future<void> loadRewardedAd() {
    return RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) async {
              // ad.dispose();
              await loadRewardedAd();
            },
          );
          state = state.copyWith(rewardedAd: ad);
        },
        onAdFailedToLoad: (err) {},
      ),
    );
  }
}

final admobProvider = StateNotifierProvider<AdmobController, AdState>((ref) {
  return AdmobController();
});

final admobProvider2 = StateNotifierProvider<AdmobController, AdState>((ref) {
  return AdmobController();
});
