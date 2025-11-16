import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'core/api/api_client.dart';
import 'core/repositories/product_repository.dart';
import 'core/state/product_provider.dart';
import 'core/config/env.dart';

void main() {
  EnvConfig.setMode(EnvMode.production);
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
          update: (_, client, __) => ProductRepository(client),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (ctx) {
            final provider = ProductProvider(ctx.read<ProductRepository>());
            provider.fetchInitial();
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SMARTKET',
        theme: buildAppTheme(),
        home: const HomeScreen(isLandscape: false),
      ),
    );
  }
}
