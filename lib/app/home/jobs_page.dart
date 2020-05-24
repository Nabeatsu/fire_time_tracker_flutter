import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerfirebase/Services/auth.dart';
import 'package:timetrackerfirebase/Services/database.dart';
import 'package:timetrackerfirebase/common_widgets/platform_alert_dialog.dart';

import 'models/job.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _createJob(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.createJob(
      Job(
        name: 'Blogging',
        ratePerHour: 11,
      ),
    );
  }
}
