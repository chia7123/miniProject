import 'package:flutter/material.dart';
import 'package:myselamat/authentication/authentication.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: 60,
            top: 150,
            child: Text(
              'My Selamat',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Authentication()));
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                label: Text(
                  'Press Here to Continue',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
          ),
        ],
      ),
    );
  }
}
