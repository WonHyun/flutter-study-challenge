import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitalizeApp {
  // bool useDevicePreview = !kReleaseMode;
  static bool useDevicePreview = false;

  static Future<void> initalize() async {
    WidgetsFlutterBinding.ensureInitialized();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }
}
