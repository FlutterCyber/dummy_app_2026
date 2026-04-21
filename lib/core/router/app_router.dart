import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetail = '/products/:id';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home'))),
      ),
      GoRoute(
        path: cart,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Cart'))),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Profile'))),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Settings'))),
      ),
      GoRoute(
        path: '/products/:id',
        builder: (_, state) => Scaffold(
          body: Center(child: Text('Product: ${state.pathParameters['id']}')),
        ),
      ),
    ],
  );
}
