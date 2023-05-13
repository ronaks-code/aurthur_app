import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Shader linearGradient = const LinearGradient(
  colors: [Color(0xFFBD6DFA), Color(0xFFEE92D0),],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: -400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Aurthur',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Audiobooks for the next generation',
                  style: TextStyle(
                    fontFamily: 'Cambria',
                    fontSize: 18.0,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60.0,
            child: Container(
              height: 60.0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFBD6DFA),
                    Color(0xFFEE92D0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: SignInButtonBuilder(
                text: 'Sign in with Apple',
                fontSize: 18.0,
                icon: Icons.apple,
                onPressed: () async {
                  // final appleIdCredential =
                  //     await SignInWithApple.getAppleIDCredential(
                  //   scopes: [
                  //     AppleIDAuthorizationScopes.email,
                  //     AppleIDAuthorizationScopes.fullName,
                  //   ],
                  // );

                  // print(appleIdCredential);
                  Navigator.pushReplacementNamed(context, '/homePage');
                },
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                elevation: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
