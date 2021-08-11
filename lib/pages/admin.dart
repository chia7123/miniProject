import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysj/authentication/auth.dart';
import 'package:mysj/widgets/admin_quick_actions.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          AdminQuickActions(),
        ],
      ),
    );
  }
}
