import 'package:flutter/material.dart';

class CheckIn extends StatelessWidget {
  // const CheckIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'Barry',
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
                      'AEON, Kampar,Perak.',
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
                      'July 19,2021',
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
                      '13:32:52',
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
                      '0123456789',
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
                    child: Text(
                      'High Risk',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
            ),
      ),
    );
  }
}
