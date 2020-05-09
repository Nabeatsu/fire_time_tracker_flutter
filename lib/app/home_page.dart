import 'package:flutter/material.dart';
import 'package:timetrackerfirebase/Services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth, @required this.onSignOut});
  final AuthBase auth;

  final VoidCallback onSignOut;
  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
