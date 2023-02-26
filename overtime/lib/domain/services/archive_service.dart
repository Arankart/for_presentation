import '../models/day_time_model.dart';
import '../models/time_calculate_model.dart';

class ArchivePageServise {
  List<DayTimeModel> _dataModel = [];
  List<DayTimeModel> get dataModel => _dataModel;
  int _selecionDataIndex = 0;
  int get selecionDateIndex => _selecionDataIndex;

  void initData(List<DayTimeModel> model) {
    _dataModel = [];
    addDataToList(model);
  }

  void addDataToList(List<DayTimeModel> model) {
    model.forEach((element) {
      _dataModel.add(element);
    });
    revertDataOfList();
  }

  void selectIndexWrite(int index) {
    _selecionDataIndex = _dataModel.length - index - 1;
  }

  void revertDataOfList() {
    _dataModel = new List.from(_dataModel.reversed);
  }

  String deltaTime(List<TimeDataModel> time) {
    int hours = 0;
    int minutes = 0;
    int minutesCount = 0;

    time.forEach((element) {
      int start_hour = element.dataStart!.hour;
      int end_hour = element.dataEnd!.hour;

      Duration diff = element.dataEnd!.difference(element.dataStart!);

      print("Diff in minutes: " + diff.inMinutes.toString());
      minutesCount += diff.inMinutes;
    });

    if (minutesCount > 60) {
      hours = minutesCount ~/ 60;
      int deltaTime = hours * 60;
      minutes = minutesCount - deltaTime;
    } else {
      minutes = minutesCount;
    }

    return '$hoursч $minutesм';
  }
}
