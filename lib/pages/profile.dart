import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysj/firstPage.dart';
import 'package:mysj/widgets/custom_view.dart';
import 'package:mysj/widgets/profile_profile_card.dart';

class ProfilePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return CustomView(
        height: MediaQuery.of(context).size.height * 0.5,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, left: 20),
            height: MediaQuery.of(context).size.height * 0.18,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MazzardH-Bold',
                  fontSize: 25.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 18.0),
            child: ProfileCard(
              riskStatus: 0,
            ),
          ),
          TextButton.icon(
              onPressed: () {
                print('Sign out');
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FirstPage()));
              },
              icon: Icon(Icons.logout,color: Colors.red,),
              label: Text('Logout',style: TextStyle(color: Colors.red),))
        ]);
  }
}
