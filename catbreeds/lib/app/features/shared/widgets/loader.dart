import 'package:catbreeds/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

final GlobalKey<_LoaderContentState> _loaderKey =
    GlobalKey<_LoaderContentState>();

class Loader {
  static show() {
    if (_loaderKey.currentState != null) {
      _loaderKey.currentState!.show();
    }
  }

  static dissmiss() {
    if (_loaderKey.currentState != null) {
      _loaderKey.currentState!.dismiss();
    }
  }
}

class LoaderProvider extends StatelessWidget {
  const LoaderProvider({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _LoaderContent(
      key: _loaderKey,
      child: child,
    );
  }
}

class _LoaderContent extends StatefulWidget {
  const _LoaderContent({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<_LoaderContent> createState() => _LoaderContentState();
}

class _LoaderContentState extends State<_LoaderContent> {
  bool showLoader = false;

  show() {
    setState(() {
      showLoader = true;
    });
  }

  dismiss() {
    setState(() {
      showLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (showLoader)
          Container(
            color: AppColors.loaderBackground,
            child: Center(
              child: Image.asset(
                'assets/gifs/loader.gif',
                height: 116,
              ),
            ),
          ),
      ],
    );
  }
}
