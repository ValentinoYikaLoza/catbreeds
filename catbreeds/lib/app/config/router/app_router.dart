import 'package:catbreeds/app/features/home/screens/detail_screen.dart';
import 'package:catbreeds/app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget transition({
  required BuildContext context,
  required Animation animation,
  required Widget child,
}) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeInOut;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  var fadeTween = Tween(begin: 0.7, end: 1.0);
  var fadeAnimation = animation.drive(fadeTween);

  return FadeTransition(
    opacity: fadeAnimation,
    child: SlideTransition(position: offsetAnimation, child: child),
  );
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        return '/home';
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return transition(
                animation: animation, context: context, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/detail',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const DetailScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return transition(
                animation: animation, context: context, child: child);
          },
        );
      },
    ),
  ],
);
