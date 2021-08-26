import 'dart:io';

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
            $c_id int NOT NULL AUTO_INCREMENT,
            $c_productID VARCHAR(255) NOT NULL,
            $c_gramm FLOAT NOT NULL,
            $c_eatenAt VARCHAR(255) NOT NULL,
            PRIMARY KEY ($c_id)
          );
          CREATE TABLE $settingsTableName (
            $s_name varchar(255) NOT NULL,
            $s_value FLOAT NOT NULL,
            PRIMARY KEY ($s_value)
          );
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES (kcal, 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES (fats, 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES (carbohydrates, 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES (protein, 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES (sugar, 0.0);
          INSERT INTO $settingsTableName ($s_name, $s_value) VALUES (weightStarted, 0.0);

          ''');
  }

  Future<int> insertConsumedProduct(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(consumedTableName, row);
  }
  

}
