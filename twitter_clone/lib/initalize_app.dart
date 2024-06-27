import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/rendering.dart';

class InitalizeApp {
  // bool useDevicePreview = !kReleaseMode;
  static bool useDevicePreview = false;

  static Future<void> initalize() async {
    WidgetsFlutterBinding.ensureInitialized();
    GoRouter.optionURLReflectsImperativeAPIs = true;
    // debugPaintPointersEnabled = true;
  }
}
