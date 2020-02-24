import 'package:flutter/foundation.dart';

class Log {
  Log._privateConstructor();

  static d(String tag, String msg) {
    if (kReleaseMode) {
      return;
    }

    print('$tag: $msg');
  }
}
