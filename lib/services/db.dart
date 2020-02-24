import 'package:pictile/utils/logger.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  final String _TAG = 'DB';

  Database _db;
  final String _dbPath = 'pictile_db.db';

  final String _setsTableKey = 'sets';
  final String _setsIdKey = 'id';
  final String _setsNameKey = 'name';

  final String _pairsTableKey = 'pairs';
  final String _pairsIdKey = 'id';
  final String _pairsImgPathKey = 'img_path';
  final String _pairsTitleKey = 'title';
  final String _pairsDescriptionKey = 'description';
  final String _pairsOrderKey = 'order_key';

  init() async {
    // open the database
    _db = await openDatabase(
      await _getPath(),
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the tables
        await _createSetsTable(db);
        await _createPairsTable(db);
        Log.d(_TAG, 'table were created');
      },
    );

    Log.d(_TAG, 'init ended');
  }

  Future<void> deleteDb() async {
    if (_db != null) {
      await deleteDatabase(await _getPath());
    }
  }

  Future<List<Map>> getSets() async {
    final selectQuery = '''
      SELECT * FROM $_setsTableKey
    ''';

    try {
      final result = await _db.rawQuery(selectQuery);
      return result;
    } catch (e) {
      _log(e);
      return [];
    }
  }

  Future<void> createSet(String name) async {
    final insertQuery = '''
      INSERT INTO $_setsTableKey ($_setsNameKey) 
      VALUES ("$name")
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  Future<void> updateSet(int id, String name) async {
    final insertQuery = '''
      UPDATE $_setsTableKey
      SET $_setsNameKey = "$name"
      WHERE id = $id;
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  Future<void> deleteSet(int id) async {
    final insertQuery = '''DELETE FROM $_setsTableKey
      WHERE $_setsIdKey=$id
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  // PRIVATE

  Future<String> _getPath() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();

    return '$databasesPath/$_dbPath';
  }

  Future<void> _createSetsTable(Database db) async {
    final createQuery = '''
      CREATE TABLE $_setsTableKey (
        $_setsIdKey INTEGER PRIMARY KEY AUTOINCREMENT,
        $_setsNameKey TEXT 
      )
    ''';

    try {
      await db.execute(createQuery);
    } catch (e) {
      _log(e);
    }
  }

  Future<void> _createPairsTable(Database db) async {
    final createQuery = '''
      CREATE TABLE $_pairsTableKey (
        $_pairsIdKey INTEGER PRIMARY KEY AUTOINCREMENT,
        $_pairsImgPathKey TEXT,
        $_pairsTitleKey TEXT,
        $_pairsDescriptionKey TEXT,
        $_pairsOrderKey INTEGER
      )
    ''';

    try {
      await db.execute(createQuery);
    } catch (e) {
      _log(e);
    }
  }

  _log(dynamic e) {
    Log.d(_TAG, 'failure: $e');
  }
}
