import 'package:catbreeds/app/features/shared/widgets/loader.dart';
import 'package:catbreeds/app/features/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return SnackbarProvider(
      child: LoaderProvider(
        child: widget.child,
      ),
    );
  }
}
