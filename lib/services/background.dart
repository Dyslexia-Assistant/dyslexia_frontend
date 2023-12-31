import 'package:flutter/material.dart';

void callbackDispatcher(Function() additionalFunction) {
  WidgetsFlutterBinding.ensureInitialized();
  print("Our background job ran!");

  // Memastikan bahwa additionalFunction tidak null sebelum dijalankan
  if (additionalFunction != null) {
    additionalFunction();
  }
}


