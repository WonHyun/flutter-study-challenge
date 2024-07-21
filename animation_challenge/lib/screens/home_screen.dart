import 'package:animation_challenge/screens/custom_painter_animation.dart';
import 'package:animation_challenge/screens/explicit_animation_screen.dart';
import 'package:animation_challenge/screens/implicit_animation_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  void _onTap(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _onTap(context, const ImplicitAnimationScreen()),
              child: const Text("Implicit animation"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _onTap(context, const ExplicitAnimationScreen()),
              child: const Text("Explicit animation"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _onTap(context, const CustomPainterAnimation()),
              child: const Text("Custom Painter"),
            ),
          ],
        ),
      ),
    );
  }
}
