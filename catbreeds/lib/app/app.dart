import 'package:catbreeds/app/features/shared/widgets/loader.dart';
import 'package:catbreeds/app/features/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoaderProvider(
      child: SnackbarProvider(
        child: child,
      ),
    );
  }
}
