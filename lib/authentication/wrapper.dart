import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myselamat/authentication/initialProfile.dart';
import 'package:myselamat/authentication/welcome.dart';
import 'package:myselamat/main.dart';
import 'package:myselamat/admin/admin.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

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
                  DocumentSnapshot<Object> doc = snapshot.data;
                  if (doc == null) {
                    return CircularProgressIndicator();
                  }
                  if (doc['name'] == '') {
                    return InitialProfileScreen();
                  }
                  if (doc['name'] == 'admin') {
                    return AdminPage();
                  } 
                  else
                    return AppHome();
                },
              );
            } else
              return Welcome();
          }),
    );
  }
}

