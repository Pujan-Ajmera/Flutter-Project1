import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory(); // ✅ Changed this
    String path = join(directory.path, 'matrimony.db');
    var db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE User(
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           userName TEXT NOT NULL,
           address TEXT NOT NULL,
           email TEXT NOT NULL,
           mobileNo TEXT NOT NULL,
           city TEXT NOT NULL,
           gender TEXT NOT NULL,
           dob TEXT NOT NULL,
           hobbies TEXT NOT NULL,
           age INTEGER NOT NULL,
           isFav INTEGER NOT NULL,
           extraDetails TEXT NOT NULL
          )''');
    }, onUpgrade: (db, oldVersion, newVersion) {}, version: 1);
    return db;
  }

  Future<List<Map<String, dynamic>>> selectAllUser() async {
    Database db = await initDatabase();
    return await db.rawQuery("SELECT * FROM User");
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    Database db = await initDatabase();
    int id = await db.insert("User", user);
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    Database db = await initDatabase();
    int id = await db.update("User", user,
        where: "id = ?", whereArgs: [user["id"]]);
  }

  Future<void> deleteUser(int passedId) async {
    Database db = await initDatabase();
    int id = await db.delete("User", where: "id = ?", whereArgs: [passedId]);
  }

  Future<void> updateIsFav(Map<String, dynamic> user, int isFav) async {
    Database db = await initDatabase();
    int id = await db.update("User", {"isFav": isFav},
        where: "id = ?", whereArgs: [user["id"]]);
  }
}
