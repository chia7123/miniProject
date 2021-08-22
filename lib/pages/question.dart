import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myselamat/data/helpers.dart';
import 'package:myselamat/data/question_sets.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final List<Question> questions = healthAssessmentQuestionSet();

  int questionYes;
  int selectedRadioButton1;
  int selectedRadioButton2;
  int selectedRadioButton3;
  int selectedRadioButton4;
  int selectedRadioButton5;
  int selectedRadioButton6;

  @override
  void initState() {
    questionYes = 0;
    selectedRadioButton1 = null;
    selectedRadioButton2 = null;
    selectedRadioButton3 = null;
    selectedRadioButton4 = null;
    selectedRadioButton5 = null;
    selectedRadioButton6 = null;
    super.initState();
  }

  void updateRisk() {
    final riskStatus = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);

    if (questionYes == 0) {
      riskStatus.update({'riskStatus': 0});
    }
    if (questionYes >= 1 && questionYes <= 5) {
      riskStatus.update({'riskStatus': 1});
    }
    if (questionYes >= 5) {
      riskStatus.update({'riskStatus': 2});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment'),
        actions: [
          TextButton(
            onPressed: () {
              questionYes = questionYes +
                  selectedRadioButton1 +
                  selectedRadioButton2 +
                  selectedRadioButton3 +
                  selectedRadioButton4 +
                  selectedRadioButton5 +
                  selectedRadioButton6;
              updateRisk();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "Your response has been succesfully submitted",
                style: TextStyle(fontFamily: "MazzardH-SemiBold"),
              )));
              Navigator.pop(context);
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '1. ' + questions[0].title,
                      style: TextStyle(
                          color: Color(0xff1c1c1c),
                          fontSize: 20.0,
                          height: 1.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (questions[0].subtitle == "")
                          ? SizedBox()
                          : Text(
                              questions[0].subtitle,
                              style: TextStyle(
                                  color: Color(0xff4f4f4f),
                                  fontSize: 15.0,
                                  height: 1.5),
                            ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedRadioButton1,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton1 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 0,
                      groupValue: selectedRadioButton1,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton1 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '2. ' + questions[1].title,
                      style: TextStyle(
                          color: Color(0xff1c1c1c),
                          fontSize: 20.0,
                          height: 1.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (questions[1].subtitle == "")
                          ? SizedBox()
                          : Text(
                              questions[1].subtitle,
                              style: TextStyle(
                                  color: Color(0xff4f4f4f),
                                  fontSize: 15.0,
                                  height: 1.5),
                            ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedRadioButton2,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton2 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 0,
                      groupValue: selectedRadioButton2,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton2 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '3. ' + questions[2].title,
                      style: TextStyle(
                          color: Color(0xff1c1c1c),
                          fontSize: 20.0,
                          height: 1.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (questions[2].subtitle == "")
                          ? SizedBox()
                          : Text(
                              questions[2].subtitle,
                              style: TextStyle(
                                  color: Color(0xff4f4f4f),
                                  fontSize: 15.0,
                                  height: 1.5),
                            ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedRadioButton3,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton3 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 0,
                      groupValue: selectedRadioButton3,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton3 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '4. ' + questions[3].title,
                      style: TextStyle(
                          color: Color(0xff1c1c1c),
                          fontSize: 20.0,
                          height: 1.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (questions[3].subtitle == "")
                          ? SizedBox()
                          : Text(
                              questions[3].subtitle,
                              style: TextStyle(
                                  color: Color(0xff4f4f4f),
                                  fontSize: 15.0,
                                  height: 1.5),
                            ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedRadioButton4,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton4 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 0,
                      groupValue: selectedRadioButton4,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton4 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '5. ' + questions[4].title,
                      style: TextStyle(
                          color: Color(0xff1c1c1c),
                          fontSize: 20.0,
                          height: 1.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (questions[4].subtitle == "")
                          ? SizedBox()
                          : Text(
                              questions[4].subtitle,
                              style: TextStyle(
                                  color: Color(0xff4f4f4f),
                                  fontSize: 15.0,
                                  height: 1.5),
                            ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedRadioButton5,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton5 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 0,
                      groupValue: selectedRadioButton5,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton5 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '6. ' + questions[5].title,
                      style: TextStyle(
                          color: Color(0xff1c1c1c),
                          fontSize: 20.0,
                          height: 1.5),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: (questions[5].subtitle == "")
                          ? SizedBox()
                          : Text(
                              questions[5].subtitle,
                              style: TextStyle(
                                  color: Color(0xff4f4f4f),
                                  fontSize: 15.0,
                                  height: 1.5),
                            ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio(
                      value: 1,
                      groupValue: selectedRadioButton6,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton6 = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio(
                      value: 0,
                      groupValue: selectedRadioButton6,
                      onChanged: (value) {
                        setState(() {
                          selectedRadioButton6 = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
