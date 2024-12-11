import 'dart:math';
import 'package:flutter/material.dart';

enum SnackbarType {
  normal,
}

final GlobalKey<_SnackbarContentState> _snackbarKey =
    GlobalKey<_SnackbarContentState>();

class SnackbarService {
  static SnackbarModel? show(
    String message, {
    SnackbarType type = SnackbarType.normal,
  }) {
    if (_snackbarKey.currentState != null) {
      final newSnackbar = _snackbarKey.currentState!.addSnackbar(message, type);
      return newSnackbar;
    }

    return null;
  }

  static remove(SnackbarModel? snackbar) {
    if (_snackbarKey.currentState != null) {
      _snackbarKey.currentState!.removeSnackbar(snackbar);
    }
  }
}

class SnackbarProvider extends StatelessWidget {
  const SnackbarProvider({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _SnackbarContent(
      key: _snackbarKey,
      child: child,
    );
  }
}

class _SnackbarContent extends StatefulWidget {
  const _SnackbarContent({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<_SnackbarContent> createState() => _SnackbarContentState();
}

class _SnackbarContentState extends State<_SnackbarContent> {
  List<SnackbarModel> snackbars = [];

  SnackbarModel addSnackbar(String message, SnackbarType type) {
    final SnackbarModel newSnackbar = SnackbarModel(
      id: _generateRandomString(10),
      message: message,
      type: type,
    );

    setState(() {
      snackbars.add(newSnackbar);
    });

    if (type == SnackbarType.normal) {
      Future.delayed(const Duration(seconds: 4), () {
        removeSnackbar(newSnackbar);
      });
    }

    return newSnackbar;
  }

  removeSnackbar(SnackbarModel? snackbar) {
    if (snackbar == null) return;
    setState(() {
      snackbars.remove(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          if (widget.child != null) widget.child!,
          Positioned(
            top: 73,
            left: screenSize.width / 2 - ((screenSize.width * 0.8) / 2),
            child: Wrap(
              direction: Axis.vertical,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              children: snackbars.reversed.toList().map((snackbar) {
                if (snackbar.type == SnackbarType.normal) {
                  return _CustomSnackbar(
                    message: snackbar.message,
                    type: snackbar.type,
                    onClose: () {
                      removeSnackbar(snackbar);
                    },
                  );
                }
                return Container();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

String _generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

class _CustomSnackbar extends StatelessWidget {
  const _CustomSnackbar({
    required this.message,
    required this.onClose,
    this.type = SnackbarType.normal,
  });

  final String message;
  final SnackbarType type;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            constraints: BoxConstraints(
              minWidth: 320,
              maxWidth: screenSize.width * 0.8,
              minHeight: 74,
            ),
            padding: const EdgeInsets.only(),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: colorScheme.primary,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 83,
                  color: colorScheme.primary,
                ),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                      height: 20 / 16,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SnackbarModel {
  final String id;
  final String message;
  final SnackbarType type;

  SnackbarModel({
    required this.id,
    required this.message,
    required this.type,
  });
}
