import '../models/day_time_model.dart';

class ArchiveDayPageServise {
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
  }
}
