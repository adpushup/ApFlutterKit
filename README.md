# AP Flutter Kit

Ap Flutter Kit is a Flutter Plugin for ApAppKit. It currently support Android Platform. It allows you to integrate AdPushup's AdX Ads into your apps.

## Get Started:

This guide is intended for publishers who want to monetize an Android app built using Flutter with AdPushup AdX ads. Integrating the Ap Flutter Kit into an app is the first step toward implementing AdPushUp AdX Ads in your app.

## Code Changes:

### A: Configuration:

To prepare your app, complete the steps in the following sections:

1. **Run this command:**

   With Flutter:

    ```bash
    flutter pub add ap_flutter_kit
    ```

   This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

    ```yaml
    dependencies:
      ap_flutter_kit: ^0.2.3
    ```

   Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

2. **Import it:**

   Now in your Dart code, you can use:

    ```dart
    import 'package:ap_flutter_kit/ap_flutter_kit.dart';
    ```


### B: Usage:

You must call `ApFlutterKit.ping()` method in your ad’s `onAdImpression()` callback.

**Example:**

```dart
onAdImpression: (Ad ad) {
	ApFlutterKit.ping(context, ad.adUnitId, ad.responseInfo?.responseId);
}
```