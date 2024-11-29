import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xffA1ACBA),
      ),
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.black12,
        backgroundColor: Colors.white,
      ),
      useMaterial3: true,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black12,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
                TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
      ),
    );
  }
}