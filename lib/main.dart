import 'package:flutter/material.dart';
import 'screens/account_screen.dart';
import 'screens/audiobook_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Container',
      navigatorKey: _navigatorKey,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/homePage': (_) => const HomePage(),
        '/audiobook': (_) => const AudiobookScreen(audiobook: {}),
        // '/home': (_) => const HomeScreen(),
        // '/account': (_) => const AccountScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    ); // MaterialApp
  }
}