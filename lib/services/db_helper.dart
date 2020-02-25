import 'package:flutter/foundation.dart';
import 'package:pictile/main.dart';

class DbHelper with ChangeNotifier {
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
}