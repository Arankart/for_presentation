// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/time_calculate_model.dart';
import '../services/timer_service.dart';

class TimerViewModelState {
  final String countText;
  final bool timeRun;
  final String timeRunText;
  final String data;
  late String interval;
  late String newNotification;
  List<String> clockTikText = [];

  TimerViewModelState(
      {required this.countText,
      required this.timeRun,
      required this.timeRunText,
      required this.data,
      required this.interval,
      required this.newNotification,
      required this.clockTikText});
}

class TimerViewModel extends ChangeNotifier {
  var _service = TimerService();

  var _state = TimerViewModelState(
      countText: "",
      timeRun: false,
      timeRunText: "",
      data: "",
      interval: "",
      newNotification: "",
      clockTikText: []);

  TimerViewModelState get state => _state;

  late Timer timerTic;

  TimerViewModel() {
    loadValue();
  }

  void addDataToDB() {
    TimeDataModel timeData =
        new TimeDataModel(_service.timeStartData, _service.timeStopData);
    _service.data.writeDataToDB(timeData);
  }

  void setInterval(int val) {
    _service.interval = val;
    _state.interval = _service.interval.toString();
    _state.newNotification = _service.newNotification;
    notifyListeners();
  }

  void startTimer() {
    loadValue();
    timerTic = Timer.periodic(const Duration(seconds: 1), (t) {
      _service.dateTodayToString;
      _service.newNotification;
      state.timeRun ? _service.countWorkTimeAndSentNotification() : null;
      updateState();
    });
  }

  void timerStop() {
    timerTic.cancel();
    print('timer stop');
  }

  void loadValue() {
    _state = TimerViewModelState(
      countText: _service.intToTime(0),
      timeRun: _service.isRun,
      timeRunText: DateFormat('hh:mm').format(_service.timeStartData),
      data: _service.dateTodayToString,
      interval: _service.interval.toString(),
      newNotification: _service.newNotification,
      clockTikText: _service.clockTikText,
    );
  }

  void updateState() {
    final count = _service.countTime;
    final isRun = _service.isRun;

    _state = TimerViewModelState(
      countText: _service.intToTime(
          DateTime.now().difference(_service.timeStartData).inSeconds),
      timeRun: _service.isRun,
      timeRunText: DateFormat('hh:mm').format(_service.timeStartData),
      data: _service.dateTodayToString,
      interval: _service.interval.toString(),
      newNotification: _service.newNotification,
      clockTikText: _service.clockTikText,
    );

    notifyListeners();
  }

  void onStartButton() {
    startTimer();
    _service.startTimer();
    updateState();
  }

  void onStopButton() {
    _service.isRun ? _service.timeSetStopData = DateTime.now() : null;

    _service.stopTimer();
    timerStop();
    loadValue();
    notifyListeners();
  }
}
