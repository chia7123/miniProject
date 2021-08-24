import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myselamat/authentication/wrapper.dart';

class ProfileCard extends StatelessWidget {
  static var riskColors = [Colors.green, Colors.orange, Colors.red];
  static var riskLabels = ["LOW RISK", "MEDIUM RISK", "HIGH RISK"];

  ProfileCard();

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.0),
      width: double.infinity,
      // height: 230.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(0.0, 3.0),
                color: Color.fromRGBO(0, 0, 0, 0.7))
          ]),
      child: StreamBuilder(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 25, right: 25, top: 30, bottom: 25),
                          //margin: EdgeInsets.only(right: 25.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          //color: Colors.amber,
                          child: Text(
                            "${doc['name'].substring(0, 1).toUpperCase()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(doc['name'],
                                style: TextStyle(fontSize: 20.0, height: 1.4)),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("IC No.",
                                      style: TextStyle(
                                          color: Color(0xff757575),
                                          fontSize: 11.5,
                                          height: 1.8)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.0),
                                    child: Text(doc['ic']),
                                  ),
                                  Text("Phone No.",
                                      style: TextStyle(
                                          color: Color(0xff757575),
                                          fontSize: 11.5,
                                          height: 1.8)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.0),
                                    child: Text(doc['phone']),
                                  ),
                                  Text("MySej ID",
                                      style: TextStyle(
                                          color: Color(0xff757575),
                                          fontSize: 11.5,
                                          height: 1.6)),
                                  Container(
                                    width: 180,
                                    padding: EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      doc['id'],
                                      softWrap: true,
                                    ),
                                  ),
                                  Text("Address",
                                      style: TextStyle(
                                          color: Color(0xff757575),
                                          fontSize: 11.5,
                                          height: 1.6)),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      doc['address'],
                                      softWrap: true,
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Text("Risk Status",
                      style: TextStyle(
                          color: Color(0xff757575),
                          fontSize: 11.5,
                          height: 1.8)),
                  Container(
                    alignment: Alignment.center,
                    width: 110.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                        color: riskColors[doc['riskStatus']],
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Transform.translate(
                      offset: Offset(0, 1.0),
                      child: Text(
                        riskLabels[doc['riskStatus']],
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'Sign Up Successful');
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Wrapper()));
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              );
            }
            return Text('no data');
          }),
    );
  }
}
