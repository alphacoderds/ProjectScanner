import 'dart:convert';
import 'package:RekaChain/ModelClass/MD_User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _tableName = 'users';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  static void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        kode_staff INTEGER PRIMARY KEY,
        nama TEXT,
        jabatan TEXT,
        unit_kerja TEXT,
        departemen TEXT,
        divisi TEXT,
        no_telp INTEGER,
        nip INTEGER,
        status TEXT,
        password TEXT
      )
    ''');
  }

  static Future<void> insertUser(User user) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> getUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }
}
