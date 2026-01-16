import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'main_page.dart';
import 'auth_provider.dart';
import 'navigation_provider.dart';

void main() => runApp(
  MultiProvider(
    // 包裹整个应用
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ],
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}
