import 'package:db/sqflite/student/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper extends Sqflite {
  static Database? _db;
  static const version = 1;
  static const lmsDbName = 'LMS';

  Future<Database> LMSDB() async {
    var path = join(await getDatabasesPath(), lmsDbName);
    return _db ??= await openDatabase(
      path,
      version: version,
      onCreate: (db, version) {
        db.execute(Student.createTable);
      },
    );
  }

  Future<List<Student>> fetchStudent() async {
    Database db = await LMSDB();
    List<Map<String, dynamic>> studentMap = await db.query(
      Student.tableName,
    );
    return studentMap.map((map) => Student.fromMap(map)).toList();
  }

  Future<bool> insertStudent(Student student) async {
    Database db = await LMSDB();
    return await db.insert(Student.tableName, student.toMap()) >= 1;
  }

  Future<bool> updateStudent(Student student, int primaryKey) async {
    Database db = await LMSDB();
    int id = await db.update(Student.tableName, student.toMap(),
        where: '${Student.colRollNo} = ?', whereArgs: [primaryKey]);

    return id >= 1;
  }

  Future<bool> deleteStudent(int primaryKey) async {
    Database db = await LMSDB();
    return await db.delete(Student.tableName,
            where: '${Student.tableName} = ?', whereArgs: [primaryKey]) >=
        1;
  }
}
