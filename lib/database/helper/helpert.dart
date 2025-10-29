import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bakery_app/database/models/models.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // Inisialisasi Database
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'bakery.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Buat tabel Purchases
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE purchases(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        buyerName TEXT,
        itemName TEXT,
        latitude REAL,
        longitude REAL,
        purchaseDate TEXT
      )
    ''');
  }

  // Simpan data Pembelian
  Future<int> insertPurchase(Purchase purchase) async {
    final db = await database;
    return await db.insert(
      'purchases',
      purchase.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Ambil semua riwayat Pembelian
  Future<List<Purchase>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'purchases',
      orderBy: 'id DESC',
    );

    return List.generate(maps.length, (i) {
      return Purchase.fromMap(maps[i]);
    });
  }
}
