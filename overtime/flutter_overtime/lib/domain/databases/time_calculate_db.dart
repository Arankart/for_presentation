import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_overtime/domain/models/time_calculate_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TimeDataDB {
  TimeDataDB._();

  static final TimeDataDB db = TimeDataDB._();
  static Database? _database;

  String tableColumn_id = 'id';
  String dbName = 'TimeData';
  String tableColumnDataStart = 'dataStart';
  String tableColumnDataEnd = 'dataEnd';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + dbName + ".db";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int vershion) async {
    return db.execute(
        'CREATE TABLE $dbName($tableColumn_id INTEGER PRIMARY KEY AUTOINCREMENT, $tableColumnDataStart TEXT, $tableColumnDataEnd TEXT)');
  }

  //READ
  Future<List<TimeDataModel>> getData() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> dataMapList = await db.query(dbName);
    List<TimeDataModel> dataList = [];
    dataMapList.forEach((element) {
      dataList.add(TimeDataModel.fromMap(element));
    });
    return dataList;
  }

  //INSERT
  Future<TimeDataModel> insertData(TimeDataModel data) async {
    Database db = await this.database;
    data.id = await db.insert(dbName, data.toMap());
    return data;
  }

  //UPDATE
  Future<int> updateData(TimeDataModel data) async {
    Database db = await this.database;
    return await db.update(dbName, data.toMap(),
        where: "$tableColumn_id = ?", whereArgs: [data.id]);
  }

  //DELETE
  Future<int> deleteData(int id) async {
    Database db = await this.database;
    return await db
        .delete(dbName, where: "$tableColumn_id = ?", whereArgs: [id]);
  }
}
