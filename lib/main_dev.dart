import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'core/api/api_client.dart';
import 'core/repositories/product_repository.dart';
import 'core/repositories/cart_repository.dart';
import 'core/repositories/smartbag_repository_mock.dart';
import 'core/state/product_provider.dart';
import 'core/state/cart_provider.dart';
import 'core/config/env.dart';
import 'core/state/navigation_provider.dart';
import 'core/state/smartbag_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  EnvConfig.setMode(EnvMode.development);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
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
        Provider<SmartbagRepositoryMock>(
            create: (_) => SmartbagRepositoryMock()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ProductProvider>(
          create: (ctx) {
            final provider = ProductProvider(ctx.read<ProductRepository>());
            provider.fetchInitial();
            return provider;
          },
        ),
        ChangeNotifierProvider<SmartbagProvider>(
          create: (ctx) {
            final provider =
                SmartbagProvider(ctx.read<SmartbagRepositoryMock>());
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi'),
          Locale('en'),
        ],
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashScreen(),
          '/welcome': (_) => const WelcomeScreen(),
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
        },
        builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
