import 'package:flutter/material.dart';
import 'package:pomotimer/global/context_extension.dart';
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

  void _scrollToCenter(int index) {
    double itemWidth = 95.0;
    double screenWidth = context.deviceWidth;

    double offset = (index * itemWidth) - screenWidth / 2 + itemWidth / 2;

    double maxScrollExtent = _controller.position.maxScrollExtent;
    double minScrollExtent = _controller.position.minScrollExtent;

    offset = offset.clamp(minScrollExtent, maxScrollExtent);

    _controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initIndex = Provider.of<PomodoroProvider>(context, listen: false)
          .selectedIndexNotifier
          .value;
      if (_controller.hasClients) {
        _scrollToCenter(initIndex);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PomodoroProvider>(context);
    return SizedBox(
      height: 60,
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
  }
}
