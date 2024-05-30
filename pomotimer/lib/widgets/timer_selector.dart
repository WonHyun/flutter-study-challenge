import 'package:flutter/material.dart';
import 'package:pomotimer/provider/pomodoro_provider.dart';
import 'package:pomotimer/widgets/timer_selector_item.dart';
import 'package:provider/provider.dart';

class TimerSelector extends StatefulWidget {
  const TimerSelector({
    super.key,
  });

  @override
  State<TimerSelector> createState() => _TimerSelectorState();
}

class _TimerSelectorState extends State<TimerSelector> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _scrollToCurrentItem(int index) async {
  //   double itemSize = 95.0;
  //   double targetOffset = itemSize * (index.toDouble());
  //   double maxScrollExtent = _controller.position.maxScrollExtent;

  //   if (targetOffset < 0) {
  //     await _controller.animateTo(
  //       0,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   } else if (targetOffset > maxScrollExtent) {
  //     await _controller.animateTo(
  //       _controller.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   } else {
  //     await _controller.animateTo(
  //       targetOffset,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  void _scrollToCenter(int index) {
    double itemWidth = 95.0;
    double screenWidth = MediaQuery.of(context).size.width;
    // double totalWidth = itemWidth * totalLength;

    double offset = (index * itemWidth) - screenWidth / 2 + itemWidth / 2;

    double maxScrollExtent = _controller.position.maxScrollExtent;
    double minScrollExtent = _controller.position.minScrollExtent;

    offset = offset.clamp(minScrollExtent, maxScrollExtent);

    // if (totalWidth <= screenWidth) {
    //   offset = 0;
    // }

    _controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        const double height = 60.0;
        return SizedBox(
          width: width,
          height: height,
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final length = provider.timeList.length;
                  return TimerSelectorItem(
                    time: provider.timeList[index % length],
                    callback: () {
                      provider.setTimerTotalSeconds(index % length);
                      _scrollToCenter(index);
                    },
                    isSelected:
                        index % length == provider.selectedIndexNotifier.value,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
