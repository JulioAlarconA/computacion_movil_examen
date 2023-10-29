import 'package:examen_alarconjulio/services/category_service.dart';
import 'package:examen_alarconjulio/services/proveedor_service.dart';
import 'package:flutter/material.dart';
import 'package:examen_alarconjulio/routes/app_routes.dart';
import 'package:examen_alarconjulio/services/auth_service.dart';
import 'package:examen_alarconjulio/services/product_service.dart';
import 'package:examen_alarconjulio/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => ProveedorService()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'examen_alarconjulio',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: MyTheme.myTheme,
    );
  }
}
