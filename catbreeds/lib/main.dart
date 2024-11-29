import 'package:catbreeds/app/app.dart';
import 'package:catbreeds/app/config/constants/environment.dart';
import 'package:catbreeds/app/config/router/app_router.dart';
import 'package:catbreeds/app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Environment.initEnvironment();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      builder: (context, child) {
        return App(
          child: child!,
        );
      },
    );
  }
}
