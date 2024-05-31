import 'package:flutter/material.dart';
import 'package:pomotimer/global/colors.dart';
import 'package:pomotimer/global/context_extension.dart';
import 'package:pomotimer/widgets/guide_text.dart';
import 'package:pomotimer/widgets/pomodoro_app_bar.dart';
import 'package:pomotimer/widgets/pomodoro_drawer.dart';
import 'package:pomotimer/widgets/progress_status_indicator.dart';
import 'package:pomotimer/widgets/timer_control_panel.dart';
import 'package:pomotimer/widgets/timer_selector.dart';
import 'package:pomotimer/widgets/timer_view.dart';

class PomodoroMainScreen extends StatefulWidget {
  const PomodoroMainScreen({
    super.key,
  });

  @override
  State<PomodoroMainScreen> createState() => _PomodoroMainScreenState();
}

class _PomodoroMainScreenState extends State<PomodoroMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onMenuTap() => _scaffoldKey.currentState?.openDrawer();
  void _onScaffoldTap() => _scaffoldKey.currentState?.closeDrawer();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              height: 72,
              decoration: const BoxDecoration(
                color: ThemeColors.plantGreen,
              ),
            ),
            Positioned(
              top: 70,
              child: CustomPaint(
                painter: CalyxPainter(),
                size: Size(context.deviceWidth, 50),
              ),
            ),
            PomodoroAppBar(onMenuTap: _onMenuTap),
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 20),
                GuideText(),
                TimerView(),
                TimerSelector(),
                TimerControlPanel(),
                ProgressStatusIndicator(),
              ],
            ),
          ],
        ),
        drawer: const PomodoroDrawer(),
      ),
    );
  }
}

class CalyxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ThemeColors.plantGreen
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width * 0.7, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
