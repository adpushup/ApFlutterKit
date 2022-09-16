import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// ApFlutterKit
class ApFlutterKit {
  static const MethodChannel _channel = MethodChannel('ap_flutter_kit');

  /// Main Ping Function. Must be called by the app when an ad impression is recorded.
  ///
  /// Throws an [PlatformException] if called on a platform other tha Android.
  static Future<void> ping(
      BuildContext context, String adUnitId, String? responseId) async {
    if (Platform.isAndroid) {
      await _channel.invokeMethod('ping', {
        'adUnitId': adUnitId,
        'responseId': responseId,
        'extra': context.runtimeType.toString()
      });
    } else {
      throw PlatformException(
          code: "1",
          message:
              "Error : AP Flutter Kit doesn't support ${Platform.operatingSystem}.");
    }
  }
}
