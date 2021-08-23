import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myselamat/authentication/wrapper.dart';
import 'package:myselamat/admin/admin_quick_actions.dart';

class AdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
              onPressed: () {
                Fluttertoast.showToast(msg: 'Sign out Successful');
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
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
