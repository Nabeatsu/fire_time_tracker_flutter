import 'package:flutter/material.dart';
import 'package:timetrackerfirebase/Services/auth.dart';
import 'package:timetrackerfirebase/Services/auth_provider.dart';
import 'package:timetrackerfirebase/app/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
