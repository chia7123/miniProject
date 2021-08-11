import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysj/authentication/auth.dart';
import 'package:mysj/authentication/initialProfile.dart';
import 'package:mysj/main.dart';
import 'package:mysj/pages/admin.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                      final doc = snapshot.data ;
                  if (doc['name'] == 'admin') {
                    return AdminPage();
                  } else if (doc['name'] == null) {
                    return InitialProfileScreen();
                  } else if (doc['name'] != 'admin' &&
                      snapshot.data['name'] != null) {
                    return AppHome();
                  } else {
                    return Text('Error');
                  }
                },
              );
            } else
              return AuthScreen();
          }),
    );
  }
}
