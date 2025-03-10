import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, 'database.db');
    var db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
  CREATE TABLE User (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_name TEXT NOT NULL,
    user_email TEXT NOT NULL
  )
  ''');
    }, version: 1);
    return db;
  }

  Future<List<Map<String,dynamic>>> getAllUsers() async {
    Database db = await initDatabase();
    return await db.rawQuery("select * from User");
  }
  Future<void> insertUser(Map<String,dynamic> user) async{
    Database db = await initDatabase();
    await db.insert("User", user);
  }
  Future<void> updateUser(Map<String,dynamic> user) async{
    Database db = await initDatabase();
   await db.update("User", user,where: "user_id = ?",whereArgs: [user["user_id"]]);
  }
  Future<void> deleteUser(Map<String,dynamic> user) async{
    Database db = await initDatabase();
    await db.delete("User", where: "user_id = ?",whereArgs: [user["user_id"]]);
  }
}
