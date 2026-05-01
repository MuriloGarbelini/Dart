import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/products_screen.dart';

void main() {
  runApp(const PetShopManagerApp());
}

class PetShopManagerApp extends StatelessWidget {
  const PetShopManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Shop Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (_) => const LoginScreen(),
        '/menu': (_) => const MenuScreen(),
        '/products': (_) => const ProductsScreen(),
      },
    );
  }
}
