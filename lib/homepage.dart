import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '/screens/account_screen.dart';
import 'screens/creator_screen.dart';
import '/screens/home_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const CreatorScreen(),
    AccountScreen(name: AppleIDAuthorizationScopes.fullName.toString(), email: AppleIDAuthorizationScopes.email.toString()),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _selectedIndex != 0,
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.5),
              ),
            ],
            gradient: const LinearGradient(
              colors: [
                Color(0xFFBD6DFA),
                Color(0xFFEE92D0),
                Color(0xFFA8C0EE),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65.0, vertical: 10),
            child: GNav(
              gap: 8,
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.transparent,
              color: Colors.blue[700],
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue.shade900.withOpacity(.3),
              selectedIndex: _selectedIndex,
              textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),

              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.create,
                  text: 'Create',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
