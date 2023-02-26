import 'package:intl/intl.dart';

class TimerService {
  int _count = 0;
  int get count => _count;

  bool _isRun = false;
  bool get isRun => _isRun;

  int _interval = 15;
  int get interval => _interval;
  set interval(int val) {
    _interval = val;
  }

  DateTime _date = DateTime.now();
  String get date => DateFormat('dd/MM/yyyy').format(_date);
  String get timeStart => DateFormat('kk:mm').format(_date);
  String get timeStop => DateFormat('kk:mm').format(_date);
  String get newNotification {
    String forReturn = timeNotificationCalculate(_date);
    return forReturn;
  }

  String timeNotificationCalculate(DateTime date) {
    DateTime newData = DateTime.now();
    int hour = newData.hour;
    int minute = newData.minute;
    int minutesCalculate;
    int hourCalculate;

    if ((minute + interval) > 59) {
      minutesCalculate = (minute + interval) - 60;
      hourCalculate = hour + 1;
    } else {
      minutesCalculate = minute + interval;
      hourCalculate = hour;
    }

    _date = newData;

    if (minutesCalculate < 59 && minutesCalculate > 9) {
      if (hourCalculate < 10) return '0$hour:$minutesCalculate';
      return '$hourCalculate:$minutesCalculate';
    } else if (minutesCalculate < 59 && minutesCalculate < 9) {
      if (hourCalculate < 10) return '0$hour:0$minutesCalculate';
      return '$hourCalculate:0$minutesCalculate';
    } else {
      return '${hourCalculate + 1}:${minutesCalculate - minute}';
    }
  }

  void decrementValue() {
    _count = _count + 1;
  }

  void startTimer() {
    _isRun = true;
    _date;
    date;
    timeStart;
  }

  void stopTimer() {
    _isRun = false;
    _date;
    date;
    timeStop;
  }
}
