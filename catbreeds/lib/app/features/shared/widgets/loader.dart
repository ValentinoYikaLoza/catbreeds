import 'package:catbreeds/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

final GlobalKey<_LoaderContentState> _loaderKey =
    GlobalKey<_LoaderContentState>();

class Loader {
  static show([String message = 'Cargando']) {
    if (_loaderKey.currentState != null) {
      _loaderKey.currentState!.show(message);
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
  String message = 'Cargando';

  show([String message = 'Cargando']) {
    setState(() {
      showLoader = true;
      this.message = message;
    });
  }

  dismiss() {
    setState(() {
      showLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.child == null
          ? const Color(0xFF3E424B).withOpacity(0.4)
          : Colors.transparent,
      body: Stack(
        children: [
          if (widget.child != null) widget.child!,
          if (showLoader)
            Container(
              color: AppColors.loaderBackground.withOpacity(0.5),
            ),
          if (showLoader)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: 230,
                  height: 80,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Row(
                          children: [
                            const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                '$message...',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
