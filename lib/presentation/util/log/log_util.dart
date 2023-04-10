import 'package:flutter/foundation.dart';

void printOnDebug(String message) {
  if (kDebugMode) {
    print(message);
  }
}