import 'dart:async';
import 'dart:io';
import 'package:gas_mvc/app/models/gas_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Singleton
class DatabaseHelper {
  // Static variable of same class type;
  static DatabaseHelper _databaseHelper;
  // Private instance of the database
  static Database _database;

  // Named constructor for creating the class instance
  DatabaseHelper._createInstance();

  //String variables used for defining the table columns
  String leituraTable = "leitura";
  String colId = "id";
  String colCubicMeterDifference = "cubicMeterDifference";
  String colCubicMeterValue = "cubicMeterValue";
  String colKgValue = "kgValue";
  String colGasPrice = "gasPrice";
  String colMoneyValue = "moneyValue";

  // Constructor
  factory DatabaseHelper() {
    /*
     * If the static variable is null, it has not been 
     * initialized it, so the variable will be created
     * using the createInstace method.
     * Otherwise, it will return the databaseHelper variable
     * because it's not null, which as been already created     *
     */
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "leituras.db";

    var contatosDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return contatosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $leituraTable ($colId INTEGER PRIMARY KEY, $colCubicMeterDifference REAL, $colCubicMeterValue REAL, $colKgValue REAL, $colGasPrice REAL, $colMoneyValue REAL)");
  }

  // Adds Leitura object into the database
  Future<int> insertLeitura(Leitura leitura) async {
    Database db = await this.database;
    var result = await db.insert(leituraTable, leitura.toMap());

    return result;
  }

  // Returns one Leitura for it's ID
  Future<Leitura> getOneLeitura(int id) async {
    Database db = await this.database;
    List<Map> maps = await db.query(leituraTable,
        columns: [
          colId,
          colCubicMeterDifference,
          colCubicMeterValue,
          colGasPrice,
          colKgValue,
          colMoneyValue
        ],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Leitura.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Returns all Leituras
  Future<List<Leitura>> getAllLeituras() async {
    Database db = await this.database;
    var result = await db.query(leituraTable);

    List<Leitura> list =
        result.isNotEmpty ? result.map((c) => Leitura.fromMap(c)).toList() : [];

    return list;
  }

  Future<int> updateLeitura(Leitura leitura) async {
    var db = await this.database;

    var result = await db.update(
      leituraTable,
      leitura.toMap(),
      where: "$colId = ?",
      whereArgs: [leitura.id],
    );

    return result;
  }

  Future<int> deleteLeitura(int id) async {
    var db = await this.database;

    int result = await db.delete(
      leituraTable,
      where: "$colId = ?",
      whereArgs: [id],
    );

    return result;
  }

  // Delete all rows in the colomun
  Future deleteAll() async {
    Database db = await this.database;

    db.delete(
      leituraTable,
      where: null,
    );
  }

  // Deletes the last value
  Future<int> deleteLastLeitura() async {
    var db = await this.database;

    int result = await db.delete(
      leituraTable,
      where: "$colId = (SELECT MAX($colId) FROM $leituraTable)",
    );

    return result;
  }
 

  // Gets the number of leitura objects  in the database
  Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT COUNT (*) from $leituraTable");
    int result = Sqflite.firstIntValue(x);

    return result;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }  
}
