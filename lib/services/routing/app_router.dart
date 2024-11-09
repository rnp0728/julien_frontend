import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/presentation/landing/landing_page.dart';
import 'package:julien/presentation/onbaording/view/onbaording_page.dart';
import 'package:julien/services/routing/routes.dart';

Widget slideTransition(
  BuildContext context,
  Animation<double> primaryAnimation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    textDirection: TextDirection.rtl,
    position: Tween<Offset>(
      begin: const Offset(
        1.0,
        0.0,
      ),
      end: Offset.zero,
    ).animate(primaryAnimation),
    child: child,
  );
}

class AppRouter {
  static GoRouter router() {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: Routes.initial,
      redirect: (context, state) {
        final visitedLandingPage =
            PersistentManager.getBool("visitedLandingPage") ?? false;
        final onWelcomePage = state.fullPath == Routes.welcome;
        return visitedLandingPage
            ? visitedLandingPage && onWelcomePage
                ? Routes.onbaording
                : null
            : Routes.welcome;
      },
      routes: [
        GoRoute(
          path: Routes.initial,
          redirect: (context, state) {
            return PersistentManager.getBool("visitedLandingPage") ?? false
                ? Routes.onbaording
                : Routes.welcome;
          },
        ),
        GoRoute(
          path: Routes.welcome,
          pageBuilder: (context, state) {
            return const CustomTransitionPage(
              child: LandingPage(),
              transitionsBuilder: slideTransition,
            );
          },
        ),
        GoRoute(
          path: Routes.onbaording,
          pageBuilder: (context, state) {
            return const CustomTransitionPage(
              child: OnbaordingPage(),
              transitionsBuilder: slideTransition,
            );
          },
        ),
      ],
    );
  }
}
