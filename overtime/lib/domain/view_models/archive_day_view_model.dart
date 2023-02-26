import 'package:flutter/material.dart';

import '../databases/hive_time_db.dart';
import '../services/archive_day_service.dart';

class ArchiveDayPageViewModel extends ChangeNotifier {
  var servise = ArchiveDayPageServise();

  void onButtonDelete(int dataIndex, int index) {
    var dataBase = HiveDB.db;
    dataBase.deleteSessionFromDay(dataIndex, index);
    notifyListeners();
  }
}
