import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myselamat/authentication/wrapper.dart';
import 'package:myselamat/widgets/custom_view.dart';
import 'package:myselamat/widgets/profile_profile_card.dart';
//import 'package:myselamat/authentication/welcome.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    // email.value = TextEditingValue(text: widget.email);
  }

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

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
            child: ProfileCard(),
          ),
          TextButton.icon(
              onPressed: () {
                _showToast("Sign Out successful");
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
        ]);
  }
}
