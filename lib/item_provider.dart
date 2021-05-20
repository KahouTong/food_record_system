import 'package:food_record_system/food_detail.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {

  DBHelper._constr();
  static final DBHelper dbInstance = new DBHelper._constr();
  factory DBHelper() => dbInstance;

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'foodItem.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE foodItem (id INTEGER PRIMARY KEY, foodName TEXT, foodType TEXT, description TEXT, expiryDate TEXT, dateRecord TEXT)');
  }

  Future<FoodItem> add(FoodItem foodItem) async {
    var dbClient = await db;
    foodItem.id = await dbClient.insert('foodItem', foodItem.toMap());
    return foodItem;
  }

  Future<List<FoodItem>> getItems() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('foodItem', columns: ['id', 'foodName','foodType','description','expiryDate','dateRecord']);
    List<FoodItem> foodItems = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        foodItems.add(FoodItem.fromMap(maps[i]));
      }
    }
    return foodItems;
  }

  Future<List<FoodItem>> getColumn() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('foodItem', columns: ['foodName','expiryDate']);
    List<FoodItem> foodItems = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        foodItems.add(FoodItem.fromMap(maps[i]));
      }
    }
    return foodItems;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'foodItem',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(FoodItem foodItem) async {
    var dbClient = await db;
    return await dbClient.update(
      'foodItem',
      foodItem.toMap(),
      where: 'id = ?',
      whereArgs: [foodItem.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}