import 'dart:async';

import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool _isForward = false;
  int _point = 0;

  late Timer _timer;
  late Duration duration;
  final curve = Curves.bounceOut;
  late final ValueNotifier<double> _bpm = ValueNotifier(120.0);

  final _maxBpm = 240;
  final _minBpm = 30;

  int _calculateBpmToMillisecends(double bpm) {
    return (1000 / (bpm / 60)).toInt();
  }

  void _onTickTimer() {
    setState(() {
      _isForward = !_isForward;
      _point = (_point + 1) % 4;
    });
  }

  void _onChangeBpm(double value) {
    _bpm.value = value;
  }

  Future<void> _onChangeEndBpm(double value) async {
    _bpm.value = value;
    duration = Duration(milliseconds: _calculateBpmToMillisecends(_bpm.value));
    setState(() {
      _isForward = true;
      _point = 0;
    });

    _timer.cancel();
    _timer = Timer.periodic(duration, (timer) => _onTickTimer());
  }

  @override
  void initState() {
    super.initState();
    duration = Duration(milliseconds: _calculateBpmToMillisecends(_bpm.value));
    _timer = Timer.periodic(duration, (timer) => _onTickTimer());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animation"),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: _isForward ? Colors.black87 : Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _bpm,
                      builder: (context, value, child) {
                        return Text(
                          "${value.truncate()} BPM",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: _isForward ? Colors.white : Colors.black87,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(4, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.all(_point >= index ? 20 : 0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isForward ? Colors.white : Colors.black87,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedScale(
                      scale: _isForward ? 0.7 : 1.0,
                      duration: duration,
                      curve: curve,
                      child: AnimatedContainer(
                        duration: duration,
                        curve: curve,
                        transform: Matrix4.rotationZ(_isForward ? 1.0 : 0),
                        transformAlignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red.shade200,
                          borderRadius:
                              BorderRadius.circular(_isForward ? 0 : 360),
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: duration,
                      alignment: _isForward
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 15,
                        color: _isForward ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: ValueListenableBuilder(
                valueListenable: _bpm,
                builder: (context, value, child) {
                  return Slider(
                    min: _minBpm.toDouble(),
                    max: _maxBpm.toDouble(),
                    value: value,
                    onChanged: _onChangeBpm,
                    onChangeEnd: _onChangeEndBpm,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
