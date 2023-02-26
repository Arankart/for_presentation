import 'package:hive/hive.dart';

part 'time_calculate_model.g.dart';

@HiveType(typeId: 2)
class TimeDataModel {
  // used 4, 5, 6
  @HiveField(4)
  DateTime? dataStart;

  @HiveField(5)
  DateTime? dataEnd;

  TimeDataModel(this.dataStart, this.dataEnd);
}
