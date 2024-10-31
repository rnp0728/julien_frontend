import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router() {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
        ),
      ],
    );
  }
}
