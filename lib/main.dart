import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hubia/screens/screens_barril.dart';

AppOpenAd? openAd;
bool isAdLoaded = false;

Future<void> loadOpenAd() async { 
  HubiaAdsIds ads = HubiaAdsIds();
  try {
    await AppOpenAd.load(
      adUnitId: ads.openApp_adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          openAd = ad;
          openAd!.show();
          isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          isAdLoaded = false;
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  } catch (e) {
    print('Error loading open ad: $e');
    isAdLoaded = false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  await loadOpenAd();

  Timer(Duration(seconds: 10), () async {
    if (!isAdLoaded) {
      openAd?.dispose();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'HubIA',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        routerConfig: appRoutes(),

        //home: const LoadingScreen(),
      ),
    );
  }
}
