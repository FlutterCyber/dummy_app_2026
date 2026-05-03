import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/products/presentation/bloc/one_product/product_bloc.dart';
import 'features/products/presentation/bloc/all_products/all_products_bloc.dart';
import 'features/products/presentation/bloc/categories/categories_bloc.dart';
import 'features/products/presentation/bloc/category_products/category_products_bloc.dart';
import 'features/products/presentation/bloc/add_product/add_product_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<ProductBloc>(create: (_) => getIt<ProductBloc>()),
        BlocProvider<AllProductsBloc>(create: (_) => getIt<AllProductsBloc>()),
        BlocProvider<CategoriesBloc>(create: (_) => getIt<CategoriesBloc>()),
        BlocProvider<CategoryProductsBloc>(
          create: (_) => getIt<CategoryProductsBloc>(),
        ),
        BlocProvider<AddProductBloc>(create: (_) => getIt<AddProductBloc>()),
        // BlocProvider<CartBloc>(create: (_) => getIt<CartBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
