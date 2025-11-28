import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'core/repositories/product_repository_mock.dart';
import 'core/repositories/cart_repository_mock.dart';
import 'core/repositories/smartbag_repository_mock.dart';
import 'core/state/product_provider.dart';
import 'core/state/cart_provider.dart';
import 'core/state/navigation_provider.dart';
import 'core/state/smartbag_provider.dart';
import 'core/state/locale_provider.dart';

void main() {
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
        Provider<ProductRepositoryMock>(create: (_) => ProductRepositoryMock()),
        Provider<CartRepositoryMock>(create: (_) => CartRepositoryMock()),
        Provider<SmartbagRepositoryMock>(
            create: (_) => SmartbagRepositoryMock()),
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
        ),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider<ProductProvider>(
          create: (ctx) {
            final provider = ProductProvider(ctx.read<ProductRepositoryMock>());
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
            final provider = CartProvider(ctx.read<CartRepositoryMock>());
            provider.fetchCart();
            return provider;
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final locale = context.watch<LocaleProvider>().locale;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SMARTKET (Mock)',
            theme: buildAppTheme(),
            locale: locale,
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
            },
            builder: (context, child) =>
                AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: child ?? const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
