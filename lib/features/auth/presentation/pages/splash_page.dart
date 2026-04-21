import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/storage/hive_service.dart';
import '../../../../core/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  void _checkToken() {
    final isLoggedIn = getIt<HiveService>().isLoggedIn;
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(isLoggedIn ? AppRouter.home : AppRouter.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80),
            SizedBox(height: 16),
            Text(
              'Shop App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
