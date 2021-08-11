import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final int riskStatus;
  final String vaccine;

  static var riskColors = [Colors.green, Colors.orange, Colors.red];
  static var riskLabels = ["LOW RISK", "SUSPECTED", "HIGH RISK"];

  ProfileCard({@required this.riskStatus, this.vaccine});

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
                      Container(
                        margin: EdgeInsets.only(right: 25.0),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                             doc['imageUrl']),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Column(
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
                        color: riskColors[riskStatus],
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Transform.translate(
                      offset: Offset(0, 1.0),
                      child: Text(
                        riskLabels[riskStatus],
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  )
                ],
              );
            }
            return Text('no data');
          }),
    );
  }
}
