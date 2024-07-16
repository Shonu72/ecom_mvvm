import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'address.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE addresses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        addressTitle TEXT,
        locality TEXT,
        city TEXT,
        state TEXT,
        pincode TEXT,
        country TEXT
      )
    ''');
  }

  Future<void> insertAddress(Map<String, dynamic> address) async {
    final db = await database;
    await db.insert(
      'addresses',
      address,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAddresses() async {
    final db = await database;
    return await db.query('addresses');
  }

  // update address
  Future<void> updateAddress(Map<String, dynamic> address) async {
    final db = await database;
    await db.update(
      'addresses',
      address,
      where: 'id = ?',
      whereArgs: [address['id']],
    );
  }
}
