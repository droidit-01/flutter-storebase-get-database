import 'package:sqflite/sqflite.dart  ';

class SQLHelper {
  static Future<void> createTebles(Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      age TEXT,
      salary TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
          )""");
  }

  static Future<Database> db() async {
    return openDatabase("database_name.db", version: 1,
        onCreate: (Database database, int version) async {
      await createTebles(database);
    });
  }

  static Future<int> createData(
      String name, String? age, String? salary) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'age': age, 'salary': salary};
    final id = await db.insert('data', data,
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('data', where: "id = ? ", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
      int id, String name, String? age, String? salary) async {
    final db = await SQLHelper.db();
    final data = {
      'name': name,
      'age': age,
      'salary': salary,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('data', data, where: "id = ? ", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('data', where: "id= ?", whereArgs: [id]);
    } catch (e) {}
  }
}
