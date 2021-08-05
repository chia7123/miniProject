import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseABC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future writeData() {
      FirebaseFirestore.instance.collection('test').add({
        'test': 'abc',
      });
    }

    return Scaffold(
      body: Column(children: [
        Container(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('location')
              .doc('Ipoh')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final doc = snapshot.data;
              return Text(doc['caseNo'].toString());
            } else
              return Text('no data');
          },
        )),
        RaisedButton(
            onPressed: () {
              writeData().whenComplete(() => print('complete'));
            },
            child: Text('write'))
      ]),
    );
  }
}
