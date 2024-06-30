import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twitter_clone/firebase_options.dart';
import 'package:twitter_clone/global/enum.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/rendering.dart';

class InitalizeApp {
  // bool useDevicePreview = !kReleaseMode;
  static const bool useDevicePreview = false;

  static Future<void> initalize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // debugPaintPointersEnabled = true;
    GoRouter.optionURLReflectsImperativeAPIs = true;

    await initHiveBoxes();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> initHiveBoxes() async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen(BoxName.settings.name)) {
      await Hive.openBox(BoxName.settings.name);
    }
  }
}
