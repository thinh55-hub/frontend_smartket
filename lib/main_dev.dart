import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'core/api/api_client.dart';
import 'core/repositories/product_repository.dart';
import 'core/repositories/cart_repository.dart';
import 'core/state/product_provider.dart';
import 'core/state/cart_provider.dart';
import 'core/config/env.dart';
import 'core/state/navigation_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  EnvConfig.setMode(EnvMode.development);
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
        Provider<ApiClient>(create: (_) => ApiClient()),
        ProxyProvider<ApiClient, ProductRepository>(
          update: (context, client, previous) => ProductRepository(client),
        ),
        ProxyProvider<ApiClient, CartRepository>(
          update: (context, client, previous) => CartRepository(client),
        ),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ProductProvider>(
          create: (ctx) {
            final provider = ProductProvider(ctx.read<ProductRepository>());
            provider.fetchInitial();
            return provider;
          },
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (ctx) {
            final provider = CartProvider(ctx.read<CartRepository>());
            provider.fetchCart();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SMARTKET (Dev)',
        theme: buildAppTheme(),
        home: const RegisterScreen(),
      ),
    );
  }
}
