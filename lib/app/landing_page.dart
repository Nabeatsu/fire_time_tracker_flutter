import 'package:flutter/material.dart';
import 'package:timetrackerfirebase/Services/auth.dart';
import 'package:timetrackerfirebase/Services/auth_provider.dart';
import 'package:timetrackerfirebase/app/home_page.dart';
import 'package:timetrackerfirebase/app/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage();
          }
          return HomePage();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
