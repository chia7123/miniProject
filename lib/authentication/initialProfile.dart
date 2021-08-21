import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myselamat/authentication/wrapper.dart';
import 'package:myselamat/main.dart';

class InitialProfileScreen extends StatefulWidget {
  static const routeName = '/initialProfile';
  // final String email;

  // InitialProfileScreen(this.email);

  @override
  _InitialProfileScreenState createState() => _InitialProfileScreenState();
}

class _InitialProfileScreenState extends State<InitialProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  CollectionReference userInfo = FirebaseFirestore.instance.collection('users');
  File _userImageFile;

  TextEditingController name = TextEditingController();
  TextEditingController ic = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController add = TextEditingController();
  TextEditingController email = TextEditingController();

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _updateProfile() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      userInfo.doc(user.uid).update({
        'name': name.text,
        'phone': phone.text,
        'address': add.text,
        'id': user.uid,
        'ic': ic.text
      }).whenComplete(() => {
            _showToast('Sign up sucessful'),
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Wrapper()))
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, top: 40),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Profile Detail',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Please fill in the following information.')),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Card(
                  margin:
                      EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 25),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              key: ValueKey('name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: '1. Name',
                              ),
                              controller: name,
                            ),
                            TextFormField(
                              key: ValueKey('ic'),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length > 12 ||
                                    value.length < 12) {
                                  return 'Please enter a valid IC No.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: '2. IC No. ',
                                  hintText: 'Example: 000123080123'),
                              controller: ic,
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                            TextFormField(
                              key: ValueKey('phone'),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.length > 11 ||
                                    value.length < 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: '3. Phone number',
                                  hintText: 'Example: 01234567890'),
                              controller: phone,
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                            TextFormField(
                              key: ValueKey('add'),
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: '4. Address ',
                              ),
                              controller: add,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateProfile,
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
