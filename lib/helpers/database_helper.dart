import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 2, // Increment version for schema change
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE login_status (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_logged_in INTEGER NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE login_status (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          is_logged_in INTEGER NOT NULL
        )
      ''');
    }
  }

  Future<void> saveUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String username) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> deleteUser(String username) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final db = await database;
    await db.insert(
      'login_status',
      {'is_logged_in': isLoggedIn ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> getLoginStatus() async {
    final db = await database;
    final result = await db.query('login_status', limit: 1);
    if (result.isNotEmpty) {
      return result.first['is_logged_in'] == 1;
    }
    return false;
  }

  Future<void> clearLoginStatus() async {
    final db = await database;
    await db.delete('login_status');
  }
}
