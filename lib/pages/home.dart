import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:myselamat/pages/hotspot.dart';
import 'package:myselamat/pages/question.dart';
import 'package:myselamat/widgets/custom_view.dart';
import 'package:myselamat/widgets/home_latest_news.dart';
import 'package:myselamat/widgets/home_welcome_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget ActionButton(
      IconData icon, String label, Color color, void Function() callback) {
    return Column(
      children: <Widget>[
        ElevatedButton(
            onPressed: callback,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                primary: color),
            child: Container(
              width: 70.0,
              height: 70.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 28.0,
                color: Colors.white,
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "MazzardH-SemiBold",
                  fontSize: 12.0,
                  height: 1.2)),
        )
      ],
    );
  }

  Widget QuickAct(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 25.0),
            child: Text(
              "Quick actions",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "MazzardH-SemiBold",
                  fontSize: 18.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ActionButton(Icons.assignment, "Assessment", Colors.blueAccent,
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => QuestionPage()));
              }),
              ActionButton(Icons.location_on, "Hotspots", Colors.orangeAccent,
                  () async {
                await _checkLocationPermission();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Hotspot(_locationData)));
              }),
              ActionButton(Icons.history, "Travel History", Colors.green, () {
                Navigator.pushNamed(context, "/travelhistory");
              })
            ],
          ),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return CustomView(height: 400.0, children: <Widget>[
      WelcomeBox(
        nearCases: 20003,
        newCasesButton: () {},
        mcoButton: () => launch(
            'https://www.mkn.gov.my/web/ms/sop-perintah-kawalan-pergerakan/'),
      ),
      Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Container(
            width: double.infinity,
            height: 1700.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 25.0),
                QuickAct(context),
                SizedBox(height: 20.0),
                LatestNews()
              ],
            ),
          )),
    ]);
  }
}
