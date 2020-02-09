import 'dart:async';

import 'package:path/path.dart';
import 'package:pengelola_uang/models/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) return;

    try {
      String _path = join(await getDatabasesPath(), 'database.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (e) {
      print(e);
    }
  }

  static FutureOr<void> onCreate(Database db, int version) {
    db.execute(
        "CREATE TABLE transactions (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name VARCHAR NOT NULL, type VARCHAR, amount INTEGER, created_at DATETIME, updated_at DATETIME)");
  }

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(
        table,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db.query(table);
}
