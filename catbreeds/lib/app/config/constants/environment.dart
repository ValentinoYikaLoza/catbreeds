import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    try {
      await dotenv.load();
    } catch (e) {
      debugPrint('Error inicializando el entorno: $e');
    }
  }

  static String urlBase = dotenv.get('URL_BASE');
}
