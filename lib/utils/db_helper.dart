import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../models/model.dart';

abstract class DBHelper {
  static Database? _db;
  static int get _version => 1;

  // Database oluşturma
  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'flutter_sqflite.db');
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
      );
    } catch (ex) {
      print(ex);
    }
  }

  // tablo oluşturma
  static void onCreate(Database db, int version) async {

    await db.execute(
      'CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, productName STRING, categoryId INTEGER, productDesc STRING, price REAL, productPic String)');

    await db.execute(
        'CREATE TABLE product_categories (id INTEGER PRIMARY KEY AUTOINCREMENT, categoryName STRING)');

    await db.execute("INSERT INTO product_categories (categoryName) VALUES ('T-Shirt'), ('Shirt'), ('Trouser'),  ('Shoes');");
  }

  static void onUpgrade(Database db, int oldVersion, int version) async {
    if (oldVersion > _version) {}
  }

  // Liste formatında veri dönecek
  static Future<List<Map<String, dynamic>>> query(String table) async {
    return _db!.query(table);
  }

  // ekleme metodu
  static Future<int> insert(String table, Model model) async {
    return await _db!.insert(table, model.toJson());
  }

  // güncelleme metodu
  static Future<int> update(String table, Model model) async {
    return await _db!.update(
      table,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  // silme metodu
  static Future<int> delete(String table, Model model) async {
    return await _db!.delete(
      table,
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
}
