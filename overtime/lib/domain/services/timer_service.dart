import 'package:flutter_overtime/domain/databases/hive_time_db.dart';
import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:intl/intl.dart';

class TimerService {
  final data = HiveDB.db;
  late List<dynamic> settings;
  // TelegramBot telegramBot = TelegramBot.telegramBot;

  int _countTime = 0;
  int get countTime => _countTime;

  bool _isRun = false;
  bool get isRun => _isRun;

  int _interval = 15;
  int get interval => _interval;

  set interval(int val) {
    _interval = val;
  }

  int _intervalSendNotificationsCount = 0;

  DateTime _date = DateTime.now();
  String get dateTodayToString => DateFormat('dd/MM/yyyy').format(_date);
  DateTime timeStartData = DateTime.now();
  set timeSetStartDate(DateTime dateTimeNow) {
    timeStartData = dateTimeNow;
  }

  late DateTime timeStopData;
  set timeSetStopData(DateTime dateTimeNow) {
    timeStopData = dateTimeNow;
  }

  String get newNotification {
    String forReturn = timeNotificationCalculate(_date);
    return forReturn;
  }

  List<String> clockTikText = [
    "А часики то тикают.",
    "А часики то тикают.",
    "А часики то тикают..."
  ];

  void writeToDB(TimeDataModel timeData) {
    data.writeDataToDB(timeData);
  }

  String timeNotificationCalculate(DateTime date) {
    DateTime newDateTime = date.add(Duration(minutes: interval));
    return DateFormat('hh:mm').format(newDateTime);
  }

  void countWorkTimeAndSentNotification() {
    _countTime = _countTime + 1;
    sentMessage();
  }

  String intToTime(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = (value - h * 3600) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return result;
  }

  void startTimer() {
    _isRun = true;
    timeSetStartDate = DateTime.now();
    _date;
  }

  void sentMessage() {
    int intervalNotifications = interval * 60;
    int notificationCount = countTime ~/ intervalNotifications;

    if (notificationCount > _intervalSendNotificationsCount) {
      _intervalSendNotificationsCount += 1;
      // telegramBot.sentMssg(
      //     'Привет, ты ещё не закончил? Если закончил, закрой таймер в приложении, добра тебе ❤️');
    }
  }

  void stopTimer() {
    _isRun = false;
    _date;
  }
}
