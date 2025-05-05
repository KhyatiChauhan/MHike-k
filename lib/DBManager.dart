import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:m_hike/Add_Hike.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  late Database database;
  String path = "";
  Future<void> initialise() async {

    var databasesPath = await getDatabasesPath();
    path = "$databasesPath" + "/hikeDataBase";


    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE HikeData (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, date TEXT, parking INTEGER, length TEXT, difficulty TEXT, description TEXT, location TEXT, image TEXT)');
    });
  }

  // Insert hike in the Database
  Future<int> insertHike(Map<String, dynamic> data, bool isForUpdate) async {

    int id1 = -1;
    path = "";
    var databasesPath = await getDatabasesPath();
    path = "$databasesPath" + "/hikeDataBase";
    database = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    ///For updating the hike date
    if (isForUpdate) {
      id1 = await database.update(
        "HikeData",
        data,
        where: 'id = ?',
        whereArgs: [data["id"]], //update by passing the id
      );
      debugPrint('inserted1: $id1');
      return id1;
    }

    ///For Adding the hike date
    else {
      id1 = await database.insert("HikeData", data);
      debugPrint('inserted1: $id1');
      return id1;
    }
  }

  // get list of all hikes from database
  Future<List<Hike>> getAllHikesFromDB() async {
    path = "";
    var databasesPath = await getDatabasesPath();
    path = "$databasesPath" + "/hikeDataBase";
    database = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    final List<Map<String, dynamic>> maps = await database.query('HikeData');

    return List.generate(maps.length, (i) {
      return Hike(maps[i]['name'], maps[i]['location'], maps[i]['date'],
          maps[i]['length'], maps[i]['difficulty'], maps[i]['description']);
    });
  }
}
