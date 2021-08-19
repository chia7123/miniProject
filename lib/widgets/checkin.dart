import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckIn extends StatelessWidget {
  // const CheckIn({Key? key}) : super(key: key);
  final String date, time, location;
  final DateFormat dateFormatter = DateFormat('dd MMM, yyyy');

  CheckIn({
    @required this.date,
    @required this.time,
    @required this.location,
  });

  @override
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

            return Scaffold(
              backgroundColor: Colors.grey.shade600,
              appBar: AppBar(
                title: Text('Check In'),
              ),
              body: Center(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    elevation: 30,
                    child: Container(
                      height: 400,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                              child: Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://thumbs.dreamstime.com/b/white-check-mark-icon-blue-background-tick-symbol-vector-illustration-isolated-143684069.jpg'))),
                            height: 80,
                          )),
                          Positioned(
                            top: 100,
                            left: 80,
                            right: 80,
                            child: Text(
                              'Check-in Sucess! Thank You!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 170,
                            left: 80,
                            right: 80,
                            child: Text(
                              'Check-in Info',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: 10,
                            child: Text(
                              'Name:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 220,
                            left: 10,
                            child: Text(
                              doc['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 250,
                            left: 10,
                            child: Text(
                              'Location:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 270,
                            left: 10,
                            child: Text(
                              this.location,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 300,
                            left: 10,
                            child: Text(
                              'Date:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 10,
                            child: Text(
                              dateFormatter
                                  .format(DateTime.parse(this.date))
                                  .toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 300,
                            left: 280,
                            child: Text(
                              'Time:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 280,
                            child: Text(
                              this.time,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 250,
                            left: 270,
                            child: Text(
                              'No. Telefon:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 270,
                            left: 250,
                            child: Text(
                              doc['phone'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 340,
                            left: 160,
                            child: Text(
                              'Risk Level',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 360,
                            left: 160,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: doc['riskStatus'] == 0
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                doc['riskStatus'] == 0
                                    ? 'Low Risk'
                                    : 'High Risk',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }

          return Text('no data');
        });
  }
}
