import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pictile/utils/logger.dart';
import 'package:sqflite/sqflite.dart';

final String setsIdKey = 'id';
final String setsNameKey = 'name';

final String pairsIdKey = 'id';
final String pairsSetIdKey = 'set_id';
final String pairsImgPathKey = 'img_path';
final String pairsTitleKey = 'title';
final String pairsDescriptionKey = 'description';
final String pairsOrderKey = 'order_key';

class Db {
  final String _TAG = 'DB';

  Database _db;
  final String _dbPath = 'pictile_db.db';
  final String _setsTableKey = 'sets';
  final String _pairsTableKey = 'pairs';

  init() async {
    // open the database
    _db = await openDatabase(
      await _getPath(),
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the tables
        await _createSetsTable(db);
        await _createPairsTable(db);
        Log.d(_TAG, 'tables were created (${db.path})');
      },
    );

    Log.d(_TAG, 'init ended');
  }

  Future<void> deleteDb() async {
    if (_db != null) {
      await deleteDatabase(await _getPath());
    }
  }

  // SETS

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
      INSERT INTO $_setsTableKey ($setsNameKey) 
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
      SET $setsNameKey = "$name"
      WHERE id = $id;
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  Future<void> deleteSet(int id) async {
    final insertQuery = '''
      DELETE FROM $_setsTableKey
      WHERE $setsIdKey=$id
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  // PAIRS

  Future<List<Map>> getPairsForSet(int setId) async {
    final selectQuery = '''
      SELECT * FROM $_pairsTableKey
      WHERE $pairsSetIdKey = $setId
    ''';

    try {
      final result = await _db.rawQuery(selectQuery);
      return result;
    } catch (e) {
      _log(e);
      return [];
    }
  }

  Future<void> createPair(
    int setId,
    String imgPath,
    String pairTitle,
    String pairDescription,
  ) async {
    //TODO add order
    final insertQuery = '''
      INSERT INTO $_pairsTableKey ($pairsSetIdKey, $pairsImgPathKey, 
        $pairsTitleKey, $pairsDescriptionKey) 
      VALUES ($setId, "$imgPath", "$pairTitle", "$pairDescription")
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  Future<void> updatePair(
    int id,
    int setId,
    String imgPath,
    String pairTitle,
    String pairDescription,
  ) async {
    final insertQuery = '''
      UPDATE $_pairsTableKey
      SET $pairsSetIdKey = $setId, $pairsImgPathKey = "$imgPath", 
        $pairsTitleKey = "$pairTitle", $pairsDescriptionKey = "$pairDescription"
      WHERE id = $id;
    ''';

    try {
      await _db.execute(insertQuery);
    } catch (e) {
      _log(e);
    }
  }

  Future<void> deletePair(int id) async {
    final insertQuery = '''
      DELETE FROM $_pairsTableKey
      WHERE $pairsIdKey = $id
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
    var databasesPath;
    if (Platform.isAndroid) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      final status = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (status == PermissionStatus.granted) {
        databasesPath = (await getExternalStorageDirectory())
            .path
            .replaceFirst('Android/data/com.genix.pictile/files', 'Pictile');
      } else {
        databasesPath = await getDatabasesPath();
      }
    } else {
      databasesPath = await getLibraryDirectory();
    }

    print('DB PATH: $databasesPath');

    return '$databasesPath/$_dbPath';
  }

  Future<void> _createSetsTable(Database db) async {
    final createQuery = '''
      CREATE TABLE $_setsTableKey (
        $setsIdKey INTEGER PRIMARY KEY AUTOINCREMENT,
        $setsNameKey TEXT 
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
        $pairsIdKey INTEGER PRIMARY KEY AUTOINCREMENT,
        $pairsSetIdKey INTEGER,
        $pairsImgPathKey TEXT,
        $pairsTitleKey TEXT,
        $pairsDescriptionKey TEXT,
        $pairsOrderKey INTEGER
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
