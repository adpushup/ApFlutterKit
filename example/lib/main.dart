import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ap_flutter_kit/ap_flutter_kit.dart';

void main() {
  // Initializing the Google Ads SDK.
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // AdRequest. You can add any extra parameter to pass in it.
  static const AdRequest request = AdManagerAdRequest();

  // Interstitial Ad Object to store loaded interstitial ad.
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    // Load an Ad when app state initialised.
    _loadAd();
  }

  // Function to load a new Interstitial Ad if one is not loaded already.
  void _loadAd() {
    if(_interstitialAd == null){
      Fluttertoast.showToast(msg: "Loading Ad...");
      InterstitialAd.load(
          adUnitId: '/6499/example/interstitial',
          request: request,
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              _interstitialAd = ad;
              _interstitialAd!.setImmersiveMode(true);
              Fluttertoast.showToast(msg: "Ad Loaded");
            },
            onAdFailedToLoad: (LoadAdError error) {
              _interstitialAd = null;
            },
          )
      );
    } else {
      Fluttertoast.showToast(msg: "Ad already Loaded");
    }
  }

  // Function to show the Interstitial Ad if ad is loaded.
  void _showAd() {
    if (_interstitialAd == null) {
      Fluttertoast.showToast(msg: "Ad not loaded yet");
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {ad.dispose();},
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {ad.dispose();},
      onAdImpression: (Ad ad) {
        // Informing about new ad impression to Ap Flutter Kit by sending a ping request to it.
        //
        // We need to pass context, Ad Unit Id, and Ad Response ID.
        ApFlutterKit.ping(context, ad.adUnitId, ad.responseInfo?.responseId);
      }
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ApAppKit Example'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Button to load new interstitial ad.
              TextButton(onPressed: () { _loadAd(); }, child: const Text('Load Ad')),
              // Button to show the loaded interstitial ad.
              TextButton(onPressed: () { _showAd(); }, child: const Text('Show Ad')),
            ],
          ),
        ),
      ),
    );
  }
}
