import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/products/presentation/pages/one_product.dart';
import '../../features/products/presentation/pages/category_products_page.dart';
import '../../features/products/presentation/pages/add_product_page.dart';
import '../../features/main/presentation/pages/main_shell.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetail = '/products/:id';
  static const String categoryProducts = '/categories/:slug';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: home,
        builder: (_, __) => const MainShell(),
      ),
      GoRoute(
        path: '/products/add',
        builder: (_, __) => const AddProductPage(),
      ),
      GoRoute(
        path: '/products/:id',
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return OneProduct(productId: id);
        },
      ),
      GoRoute(
        path: '/categories/:slug',
        builder: (_, state) {
          final slug = state.pathParameters['slug']!;
          final name = state.extra as String? ?? slug;
          return CategoryProductsPage(slug: slug, categoryName: name);
        },
      ),
    ],
  );
}
