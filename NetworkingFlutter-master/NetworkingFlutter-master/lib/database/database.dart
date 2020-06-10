import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:networking_demo/models/sites.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "FireData.db");
      return await openDatabase(path, version: 1, onOpen: (db) {},
          onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE SITES(id INTEGER PRIMARY KEY AUTOINCREMENT, siteName TEXT, addressName TEXT,notes TEXT,createdDate TEXT,panelCount INTEGER)",
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addRecord(String table, Sites site) async {
    final db = await database;
    try {
      await db.insert(table, site.toMap());
    } catch (exception) {
      print(exception.toString());
    }
  }

  updateRecord(String table, Sites site) async {
    final db = await database;
    await db.update(table, site.toMap(), where: 'id=?', whereArgs: [site.id]);
  }

  deleteRecord(String table, Sites site) async {
    final db = await database;
    await db.delete(table, where: 'id=?', whereArgs: [site.id]);
  }

//  AddSite(Sites site) async {
//    final db = await database;
//    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM SITES");
//    int id = table.first["ID"];
//    var raw = await db.rawInsert(
//        "INSERT INTO SITES(ID,SiteName)" "VALUES(?,?,?,?)",
//        [id, site.siteName, site.DisplayDate, site.panelCount.toString()]);
//    return raw;
//  }
//
//  UpdateSite(Sites site) async {
//    final db = await database;
//    var res = await db
//        .update("SITES", site.toMap(), where: "id = ?", whereArgs: [site.id]);
//    return res;
//  }
//
//  DeleteSite(int siteId) async {
//    final db = await database;
//    var res = await db.delete("SITES", where: "id=?", whereArgs: [siteId]);
//    return res;
//  }

  Future<List<Sites>> getAllSites() async {
    try {
      final db = await database;
      List<Map> sqlResult = await db.query("SITES",columns: ['id','siteName','addressName','notes','createdDate','panelCount']);

      List<Sites> siteDbList = [];
      if (sqlResult.length > 0) {
        for (int i = 0; i < sqlResult.length; i++) {
          siteDbList.add(Sites.fromMap(sqlResult[i]));
        }
      }
      return siteDbList;
    } catch (GetExec) {
      print(GetExec);
      return null;
    }
  }
}
