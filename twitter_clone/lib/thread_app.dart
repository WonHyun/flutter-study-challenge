import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/global/theme.dart';
import 'package:twitter_clone/providers/providers.dart';
import 'package:twitter_clone/router.dart';

class ThreadApp extends ConsumerWidget {
  const ThreadApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      themeMode: ref.watch(settingProvider).themeMode,
      theme: TwitterTheme.light,
      darkTheme: TwitterTheme.dark,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
