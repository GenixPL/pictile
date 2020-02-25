import 'package:flutter/foundation.dart';
import 'package:pictile/main.dart';

class DbHelper with ChangeNotifier {
  // SETS

  Future<List<Map>> getSets() async {
    return db.getSets();
  }

  Future<void> createSet(String name) async {
    await db.createSet(name);

    notifyListeners();
  }

  Future<void> updateSet(int id, String name) async {
    await db.updateSet(id, name);

    notifyListeners();
  }

  Future<void> deleteSet(int id) async {
    await db.deleteSet(id);

    notifyListeners();
  }

  // PAIRS

  Future<List<Map>> getPairsForSet(int setId) async {
    return db.getPairsForSet(setId);
  }

  Future<void> createPair(
    int setId,
    String imgPath,
    String pairTitle,
    String pairDescription,
  ) async {
    await db.createPair(setId, imgPath, pairTitle, pairDescription);

    notifyListeners();
  }

  Future<void> updatePair(
    int id,
    int setId,
    String imgPath,
    String pairTitle,
    String pairDescription,
  ) async {
    await db.updatePair(id, setId, imgPath, pairTitle, pairDescription);

    notifyListeners();
  }

  Future<void> deletePair(int id) async {
    await db.deletePair(id);

    notifyListeners();
  }
}
