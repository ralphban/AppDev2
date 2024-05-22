import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await open();
    }
    return _db!;
  }

  Future<Database> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_db.db');
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL
        );
      ''');
    });
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    var client = await db;
    return client.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    var client = await db;
    return client.query('users');
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    var client = await db;
    return client.update('users', user, where: 'id = ?', whereArgs: [user['id']]);
  }

  Future<void> deleteUser(int id) async {
    var client = await db;
    await client.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
