import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/main/layouts/main_navigaion_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const MainNavigaionBar(),
    );
  }
}
