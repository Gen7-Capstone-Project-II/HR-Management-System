import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/consts/app_const.dart';
import 'package:sqflite/sqflite.dart';

///
/// [SqlLitDatabaseProvider] is a wrapper for the sqflite package.
/// It provides a simple interface for [creating], [reading], [updating], and [deleting] data from a SQLite database.
///
/// [SqlLitDatabaseProvider] is used for storing data locally withing the app.
///
class SqlLitDatabaseProvider {
  String? _dbName;
  Database? _database;

  SqlLitDatabaseProvider(this._dbName);

  Future open() async {
    _database ??= await openDatabase(_dbName ??= AppConst.APP_DB_NAME, version: 1, onCreate: (Database db, int version) async {}, onUpgrade: (Database db, int oldVersion, int version) async {});
  }

  Future close() async => _database!.close();
  Database getDatabase() => _database!;

  /// It inserts a new row into the table.
  ///
  /// Args:
  ///   [tableName] (String): The name of the table you want to insert into.
  ///   [params] (Map<String, dynamic>): A map of column names and values to insert.
  Future<int> insert(String tableName, Map<String, dynamic> params) async {
    await open();
    return await _database!.insert(tableName, params).whenComplete(() async {
      //await close();
    });
  }

  /// Execute an INSERT statement and return the last inserted row id.
  ///
  /// Args:
  ///   [insertQuery] (String): The query to be executed.
  ///   [arguments] (List<dynamic>): The values to insert.
  Future<int> rawInsert(String insertQuery, [List<dynamic>? arguments]) async {
    await open();
    return await _database!.rawInsert(insertQuery, arguments).whenComplete(() async {
      //await close();
    });
  }

  /// Execute a raw SQL update statement.
  ///
  /// Args:
  ///   [updateQuery] (String): The query to run.
  ///   [arguments] (List<dynamic>): A list of values to be used in the query.
  Future<int> rawUpdate(String updateQuery, [List<dynamic>? arguments]) async {
    await open();
    return await _database!.rawUpdate(updateQuery, arguments).whenComplete(() async {
      //await close();
    });
  }

  /// Execute a raw SQL DELETE statement and return the number of rows affected.
  ///
  /// Args:
  ///   [deleteQuery] (String): The query to be executed.
  ///   [arguments] (List<dynamic>): The arguments to be passed to the query.
  Future<int> rawDelete(String deleteQuery, [List<dynamic>? arguments]) async {
    await open();
    return await _database!.rawDelete(deleteQuery, arguments).whenComplete(() async {
      //await close();
    });
  }

  Future<List<Map<String, dynamic>>> rawQuery(String query, [List<dynamic>? arguments]) async {
    await open();
    return await _database!.rawQuery(query, arguments).whenComplete(() async {
      //wait close();
    });
  }

  /// Execute a raw SQL query and return the first row of the result set.
  ///
  /// Args:
  ///   [query] (String): The query to execute.
  ///   [arguments] (List<dynamic>): The optional positional parameters for the query.
  Future<Map<String, dynamic>?> firstRawQuery(String query, [List<dynamic>? arguments]) async {
    List<Map<String, dynamic>> list = await rawQuery(query, arguments);
    if (list.isNotEmpty) {
      return list[0];
    }
    return null;
  }

  /// Execute a query and return the number of rows that were changed.
  ///
  /// Args:
  ///   [query] (String): The query to execute.
  ///   [arguments] (List<dynamic>): A list of positional parameters to be passed to the query.
  Future<int?> count(String query, [List<dynamic>? arguments]) async {
    return Sqflite.firstIntValue(await rawQuery(query, arguments));
  }

  /// It checks if the table exists in the database.
  ///
  /// Args:
  ///   [tableName] (String): The name of the table to check.
  Future<int?> checkTableExist(String tableName) async {
    return Sqflite.firstIntValue(await rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name='$tableName'"));
  }

  /// Check if a column exists in a table
  ///
  /// Args:
  ///   [tableName] (String): The name of the table to check.
  ///   [columnName] (String): The name of the column you want to check.
  Future<bool> checkColumnExist(String tableName, String columnName) async {
    String query = "PRAGMA table_info('$tableName')";
    debugPrint(query);

    return rawQuery(query).then((list) {
      bool exist = false;
      for (Map<String, dynamic> columnMap in list) {
        debugPrint(columnMap.toString());
        if (columnMap['name'] == columnName) {
          exist = true;
          break;
        }
      }
      return exist;
    }).catchError((error) {
      debugPrint(error.toString());
      return false;
    });
  }
}

SqlLitDatabaseProvider sqlLitDatabaseProvider = SqlLitDatabaseProvider(AppConst.APP_DB_NAME);
