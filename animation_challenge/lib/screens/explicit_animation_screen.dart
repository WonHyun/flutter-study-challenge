import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  final rowCount = 5;
  final columnCount = 5;
  late final totalItems = rowCount * columnCount;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();

  late final _tweens = List.generate(totalItems, (index) {
    int y = index ~/ columnCount;
    int x = index % columnCount;

    int zigzagX = y.isEven ? x : columnCount - 1 - x;
    int position = y * columnCount + zigzagX;

    double start = (totalItems - 1 - position) / totalItems;
    double end = start + (1.0 / totalItems);

    return TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: 1.0),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.1),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          start,
          end,
          curve: Curves.bounceOut,
        ),
      ),
    );
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text("Explicit Animation"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
              ),
              itemCount: rowCount * columnCount,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                    animation: _tweens[index],
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(_tweens[index].value),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
