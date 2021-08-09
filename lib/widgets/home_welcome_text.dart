import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysj/widgets/custom_icons.dart';

class WelcomeBox extends StatelessWidget {
  final int nearCases;
  final void Function() newCasesButton;
  final void Function() mcoButton;

  WelcomeBox(
      {@required this.nearCases,
      @required this.newCasesButton,
      @required this.mcoButton});

  // ignore: non_constant_identifier_names
  Widget InfoButton(
      IconData icon, String title, String subtitle, void Function() callback) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)))),
      child: SizedBox(
        width: 138.0,
        height: 60.0,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                icon,
                color: Color(0xff3166fd),
                size: 30.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xff3166fd),
                    fontFamily: "MazzardH-Bold",
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      fontFamily: "MazzardH-SemiBold",
                      fontSize: 12.0,
                      height: 1.0),
                )
              ],
            )
          ],
        ),
      ),
      onPressed: callback,
    );
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            final doc = snapshot.data;
            return Column(
              children: <Widget>[
                Container(
                  width: 380.0,
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  child: Text(
                    "Hello ${doc['name']},\nthere are ${this.nearCases} new cases near you this week.",
                    style: TextStyle(
                      height: 1.5,
                      letterSpacing: 0.5,
                      color: Colors.white,
                      fontFamily: "MazzardH-SemiBold",
                      fontSize: 28.0,
                    ),
                  ),
                ),
                Container(
                    width: 350.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InfoButton(CustomIcons.show_chart, "7,703",
                            "new cases today", newCasesButton),
                        InfoButton(CustomIcons.shield, "MCO 3.0",
                            "view guidelines", mcoButton)
                      ],
                    )),
              ],
            );
          }
          return Text('no data');
        });
  }
}
