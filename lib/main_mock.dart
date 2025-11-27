import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'core/repositories/product_repository_mock.dart';
import 'core/repositories/cart_repository_mock.dart';
import 'core/state/product_provider.dart';
import 'core/state/cart_provider.dart';
import 'core/state/navigation_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SmartketApp());
}

class SmartketApp extends StatelessWidget {
  const SmartketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductRepositoryMock>(create: (_) => ProductRepositoryMock()),
        Provider<CartRepositoryMock>(create: (_) => CartRepositoryMock()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ProductProvider>(
          create: (ctx) {
            final provider = ProductProvider(ctx.read<ProductRepositoryMock>());
            provider.fetchInitial();
            return provider;
          },
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (ctx) {
            final provider = CartProvider(ctx.read<CartRepositoryMock>());
            provider.fetchCart();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SMARTKET (Mock)',
        theme: buildAppTheme(),
        home: const HomeScreen(isLandscape: false),
      ),
    );
  }
}
