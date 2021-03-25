import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<void> database(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    // On create will run if there is no budget.db in the specified path
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'budget.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_budget(id TEXT PRIMARY KEY,title TEXT,amount DECIMAL(10,5),date TEXT)");
    }, version: 1);
    sqlDb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    // On create will run if there is no budget.db in the specified path
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'budget.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_budget(id TEXT PRIMARY KEY,title TEXT,amount DECIMAL(10,5),date TEXT)");
    }, version: 1);
    sqlDb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
