import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PomodoroProvider extends ChangeNotifier {
  final int _minuteInterval = 5;
  final List<int> _timeList = [];
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(4);

  bool _isRunning = false;
  bool _isRest = false;

  final int _restTime = 5 * 60;
  int _totalSeconds = 0;
  int _currentSeconds = 0;
  int _tick = 0;

  int _totalRound = 4;
  int _totalGoal = 12;
  int _currentRound = 0;
  int _currentGoal = 0;

  String _guideText = "";

  List<int> get timeList => _timeList;
  ValueNotifier<int> get selectedIndexNotifier => _selectedIndexNotifier;

  bool get isRunning => _isRunning;
  bool get isRest => _isRest;

  int get restTime => _restTime;
  int get totalSeconds => _totalSeconds;
  int get currentSeconds => _currentSeconds;
  int get tick => _tick;

  int get totalRound => _totalRound;
  int get totalGoal => _totalGoal;
  int get currentRound => _currentRound;
  int get currentGoal => _currentGoal;

  String get guideText => _guideText;

  Timer _timer = Timer(Duration.zero, () => {});

  PomodoroProvider() {
    for (int minute = _minuteInterval; minute < 60; minute += _minuteInterval) {
      _timeList.add(minute);
    }

    _totalSeconds = _timeList[_selectedIndexNotifier.value] * 60;
    _currentSeconds = _totalSeconds;
  }

  void onStartTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      onTick,
    );
    _isRunning = true;
    notifyListeners();
  }

  void onTick(Timer timer) {
    if (_currentSeconds == 0) {
      onSkipNextCycle();
    } else {
      _currentSeconds = _currentSeconds - _tick;
      _tick++;
      _tick = _tick % 2;
    }
    notifyListeners();
  }

  void onPause() {
    _timer.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void onTimerReset() {
    _currentSeconds = _isRest ? _restTime : _totalSeconds;
    notifyListeners();
  }

  void onSkipNextCycle() {
    if (_isRest) {
      _currentSeconds = _totalSeconds;
      _guideText = "";
      _isRest = false;
      onPause();
    } else {
      _currentRound++;
      _currentGoal = _currentGoal + (_currentRound / _totalRound).truncate();
      _currentRound = _currentRound % _totalRound;
      _isRest = true;
      _currentSeconds = _restTime;
      _guideText = "TAKE A REST!";
      onPause();
    }
    notifyListeners();
  }

  void setTimer(int totalSeconds) {
    _totalSeconds = totalSeconds * 60;
    _currentSeconds = _totalSeconds;
    notifyListeners();
  }

  String getCurrentSeconds() {
    return Duration(seconds: _currentSeconds)
        .toString()
        .split(".")
        .first
        .substring(2, 7)
        .replaceAll(":", "");
  }

  void setTimerTotalSeconds(int index) {
    if (_selectedIndexNotifier.value != index) {
      _selectedIndexNotifier.value = index;
    }

    _totalSeconds = _timeList[_selectedIndexNotifier.value] * 60;
    _currentSeconds = _totalSeconds;
    notifyListeners();
  }

  void onClearAllProgress() {
    onPause();
    _currentRound = 0;
    _currentGoal = 0;
    _isRest = false;
    _guideText = "";
    onTimerReset();
    notifyListeners();
  }

  void onChangeMaxRound(int newValue) {
    if (newValue > 0) {
      _totalRound = newValue;
    }
    notifyListeners();
  }

  void onChangeMaxGoal(int newValue) {
    if (newValue > 0) {
      _totalGoal = newValue;
    }
    notifyListeners();
  }
}
