import 'dart:async';
import 'dart:math';
import 'package:catbreeds/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final GlobalKey<_SnackbarContentState> _snackbarKey =
    GlobalKey<_SnackbarContentState>();

class SnackbarService {
  static show(String message) {
    if (_snackbarKey.currentState != null) {
      _snackbarKey.currentState!.addSnackbar(message);
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
  List<_Snackbar> snackbars = [];

  addSnackbar(String message) {
    final _Snackbar newSnackbar = _Snackbar(
      id: _generateRandomString(10),
      message: message,
    );

    setState(() {
      snackbars.add(newSnackbar);
    });

    Future.delayed(const Duration(seconds: 4), () {
      removeSnackbar(newSnackbar);
    });
  }

  removeSnackbar(_Snackbar snackbar) {
    setState(() {
      snackbars.remove(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (widget.child != null) widget.child!,
          Positioned(
            top: 50,
            right: 20,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 16,
              children: snackbars.reversed.toList().map((snackbar) {
                return _CustomSnackbar(
                  message: snackbar.message,
                  onClose: () {
                    removeSnackbar(snackbar);
                  },
                );
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
  });

  final String message;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            constraints: const BoxConstraints(
              minHeight: 83,
            ),
            padding: const EdgeInsets.only(),
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: AppColors.secundary90,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 83,
                  color: AppColors.grey2,
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secundary90,
                    height: 20 / 16,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 3,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onClose,
              child: SvgPicture.asset(
                'assets/icons/close_2.svg',
                height: 34,
                width: 34,
                colorFilter: const ColorFilter.mode(
                  AppColors.secundary90,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Snackbar {
  final String id;
  final String message;

  _Snackbar({
    required this.id,
    required this.message,
  });
}
