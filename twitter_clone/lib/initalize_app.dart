import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InitalizeApp {
  // bool useDevicePreview = !kReleaseMode;
  static bool useDevicePreview = false;

  static Future<void> initalize() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
