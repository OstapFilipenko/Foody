import 'dart:io';

import 'package:foody/backend/localModels/product_consumed.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static final _databaseName = "Foody.db";
  static final _databaseVersion = 1;

  static final consumedTableName = "ProductsConsumed";
  static final c_id = "ID";
  static final c_productID = "ProductID";
  static final c_gramm = "Gramm";
  static final c_eatenAt = "EatenAt";

  static final settingsTableName = "Settings";
  static final s_name = "Name";
  static final s_value = "Value";

  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $consumedTableName (
            $c_id INT NOT NULL AUTOINCREMENT,
            $c_productID VARCHAR(255) NOT NULL,
            $c_gramm INT NOT NULL,
            $c_eatenAt VARCHAR(255) NOT NULL,
            PRIMARY KEY ($c_id)
          );
          CREATE TABLE $settingsTableName (
            $s_name varchar(255) NOT NULL,
            $s_value DOUBLE NOT NULL,
            PRIMARY KEY ($s_value)
          );
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES ('kcal', 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES ('fats', 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES ('carbohydrates', 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES ('protein', 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES ('sugar', 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES ('weightStarted', 0.0);

          ''');
  }

  Future<int> insertConsumedProduct(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(consumedTableName, row);
  }
  
  Future<void> updateKcal(double kcal) async {
    Database db = await instance.database;
    await db.execute('''
      UPDATE $settingsTableName SET $s_value = $kcal WHERE $s_name = 'kcal';
    ''');
  }

  Future<void> updateFats(double fats) async {
    Database db = await instance.database;
    await db.execute('''
      UPDATE $settingsTableName SET $s_value = $fats WHERE $s_name = 'fats';
    ''');
  }

  Future<void> updateCarbohydrates(double carbohydrates) async {
    Database db = await instance.database;
    await db.execute('''
      UPDATE $settingsTableName SET $s_value = $carbohydrates WHERE $s_name = 'carbohydrates';
    ''');
  }

  Future<void> updateProtein(double protein) async {
    Database db = await instance.database;
    await db.execute('''
      UPDATE $settingsTableName SET $s_value = $protein WHERE $s_name = 'protein';
    ''');
  }

  Future<void> updateSugar(double sugar) async {
    Database db = await instance.database;
    await db.execute('''
      UPDATE $settingsTableName SET $s_value = $sugar WHERE $s_name = 'sugar';
    ''');
  }

  Future<void> updateWeightStarted(double weightStarted) async {
    Database db = await instance.database;
    await db.execute('''
      UPDATE $settingsTableName SET $s_value = $weightStarted WHERE $s_name = 'weightStarted';
    ''');
  }

  Future<void> updateConsumedProduct(ProductConsumed productConsumed) async {
    Database db = await instance.database;
    int gramm = productConsumed.getGramm();
    String eatenAt = productConsumed.getEatenAt();
    String productID = productConsumed.getProductID();
    await db.execute('''
      UPDATE $consumedTableName SET $c_gramm = $gramm WHERE $c_eatenAt = '$eatenAt' AND $c_productID = '$productID'
    ''');
  }

  Future<void> deleteConsumedProduct(ProductConsumed productConsumed) async {
    Database db = await instance.database;
    String eatenAt = productConsumed.getEatenAt();
    String productID = productConsumed.getProductID();
    await db.execute('''
      DELETE FROM $consumedTableName WHERE $c_eatenAt = '$eatenAt' AND $c_productID = '$productID'
    ''');
  }

}
