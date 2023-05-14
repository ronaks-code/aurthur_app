import 'package:aurthur_app/screens/audiobook_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'homepage.dart';
// import 'screens/audiobook_screen.dart';
// import 'screens/account_screen.dart';
// import 'screens/home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return MaterialApp(
      title: 'Main Container',
      navigatorKey: _navigatorKey,
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (context) => const LoginScreen(),
        '/homePage': (context) => const HomePage(),
        // '/audiobook': (context) => const AudiobookScreen(),
        // '/home': (BuildContext context) => const HomeScreen(),
        // '/account': (BuildContext context) => const AccountScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    ); // MaterialApp
  }
}