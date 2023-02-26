import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:hive/hive.dart';

part 'day_time_model.g.dart';

@HiveType(typeId: 1)
class DayTimeModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  List<TimeDataModel>? dataList;

  @HiveField(2)
  DateTime date = DateTime.now();

  DayTimeModel(this.id, this.dataList, this.date);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['dataList'] = dataList;
    map['date'] = date;
    return map;
  }

  DayTimeModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dataList = map['dataList'];
    date = map['date'];
  }

  DayTimeModel copyWith({
    int? id,
    List<TimeDataModel>? dataList,
    DateTime? date,
  }) {
    return DayTimeModel(
        id ?? this.id, dataList ?? this.dataList, date ?? this.date);
  }
}
