import 'dart:ffi';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/day_time_model.dart';
import '../models/time_calculate_model.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HiveDB {
  HiveDB._();

  static final HiveDB _db = HiveDB._();
  static HiveDB get db => _db;

  static const String _nameTimeDB = 'timeDataDB';
  static const String _nameSettingsDB = 'settingsDB';

  static String userIdName = 'userId';
  static String intervalTimeName = 'intervalTime';

  Future<List<DayTimeModel>> getTimeData() async {
    var box = await Hive.openBox(_nameTimeDB);
    List<DayTimeModel> dataList = [];
    box.values.forEach((element) {
      dataList.add(element);
    });
    await box.close();
    return dataList;
  }

  Future<List<dynamic>> getSettingsData() async {
    var box = await Hive.openBox(_nameSettingsDB);
    List<dynamic> dataList = [];
    box.values.forEach((element) {
      dataList.add(element);
    });
    await box.close();
    return dataList;
  }

  Future<int> getIntervalData() async {
    var box = await Hive.openBox(_nameSettingsDB);
    String intervalValue = box.get(intervalTimeName);
    await box.close();
    return intervalValue as int;
  }

  Future<void> writeDataToDB(TimeDataModel timeData) async {
    var dateNow = DateTime.now();
    var box = await Hive.openBox<DayTimeModel>(_nameTimeDB);
    TimeDataModel newTimeData =
        TimeDataModel(timeData.dataStart, timeData.dataEnd);

    int minuteDelta = timeData.dataEnd!.minute - timeData.dataStart!.minute;

    if (box.isEmpty) {
      List<TimeDataModel> listDataTime = [newTimeData];
      int id = box.values.length;

      DayTimeModel dataAddId = new DayTimeModel(id, listDataTime, dateNow);
      await box.add(dataAddId);
    } else {
      if (box.values.last.date.day != newTimeData.dataEnd!.day) {
        List<TimeDataModel> listDataTime = [newTimeData];
        int id = box.values.length;
        DayTimeModel dataAddId = new DayTimeModel(id, listDataTime, dateNow);

        await box.add(dataAddId);
      } else {
        int index = box.keys.length - 1;
        List<TimeDataModel> dataList = [];
        var oldData = box.values.last.date;
        DateTime newDateTime = DateTime(
            oldData.year,
            oldData.month,
            oldData.day,
            oldData.hour,
            minuteDelta,
            oldData.second,
            oldData.microsecond,
            oldData.microsecond);

        box.values.last.dataList?.forEach((element) {
          dataList.add(element);
        });
        dataList.add(newTimeData);

        DayTimeModel dataAddId = new DayTimeModel(index, dataList, newDateTime);

        await box.put(index, dataAddId);
      }
    }

    await box.close();
  }

  Future<void> checkInfoDB() async {
    var dateNow = DateTime.now();
    var box = await Hive.openBox(_nameTimeDB);

    print("кол-во элементов: " + box.values.length.toString());
    box.values.forEach((element) {
      print("Айди: ${element}, дата: ${element.dateTodayToString}");
      int count = 0;
      print("Кол-во элементов в списке${element.dataList!.length}");
      element.dataList!.forEach((e) {
        print(" id: $count,");
        print(" ${e.dataStart}");
        print(" ${e.dataEnd}");
        count++;
      });
    });

    await box.close();
  }

  Future<void> deleteObj() async {
    var box = await Hive.openBox(_nameTimeDB);
    await box.deleteAt(2);
    await box.close();

    print("data was deleted");
  }

  Future<void> deleteSessionFromDay(int dataIndex, int index) async {
    if (Hive.isBoxOpen(_nameTimeDB)) Hive.close();

    var box = await Hive.openBox(_nameTimeDB);

    List<DayTimeModel> dbData = [];
    List<TimeDataModel> dataIndexSessions = [];

    box.values.forEach((element) {
      dbData.add(element);
    });

    dbData[dataIndex].dataList!.forEach((element) {
      dataIndexSessions.add(element);
    });

    dataIndexSessions.removeAt(index);

    DayTimeModel newDayModel = DayTimeModel(
        dbData[dataIndex].id, dataIndexSessions, dbData[dataIndex].date);

    await box.put(dataIndex, newDayModel);
    await box.close();
  }
}
