import 'dart:collection';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapCard extends StatefulWidget {
  final LocationData location;
  MapCard({@required this.location});

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  List<Color> riskColors = [Colors.green, Colors.orange, Colors.red];
  List<String> riskLabels = ["LOW RISK", "MEDIUM RISK", "HIGH RISK"];
  var riskimage = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flat_tick_icon.svg/768px-Flat_tick_icon.svg.png",
    "https://img.icons8.com/ios-filled/452/low-risk.png",
    "https://icon-library.com/images/high-risk-icon/high-risk-icon-0.jpg",
  ];

  List<DropdownMenuItem> items = [];
  String selectedValue = '';
  String _previewImageUrl = '';

  LocationData _locationData;

  // Maps
  bool _isMarker = true;
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;
  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController _googleMapController;
  BitmapDescriptor _markerIcon;

  //firestore
  List<String> location = [
    'Taman Kampar Perdana',
    'Taman Bandar Baru',
    'Taman Bandar Baru Selatan',
    'Kampung Masjid',
    'Kampar Putra'
  ];
  int caseNo;
  int riskLevel;
  List<GeoPoint> coord;

  //myLocation
  LatLng myLocation;
  int myRiskLevel = 0;
  int myCaseNo = 0;
  List<LatLng> searchLocation = [
    LatLng(4.337095616814854, 101.15402117371559),
    LatLng(4.326610390665372, 101.14343617111444),
    LatLng(4.315415246437441, 101.14251181483269),
    LatLng(4.317517482860365, 101.1523612216115),
    LatLng(4.323137125387374, 101.12983636558056)
  ];

  @override
  void initState() {
    super.initState();
    _locationData = widget.location;
    myLocation = LatLng(_locationData.latitude, _locationData.longitude);
    getData();
  }

  void getData() {
    for (var i = 0; i < location.length; i++) {
      List<LatLng> polygonLatLngs = List<LatLng>();

      FirebaseFirestore.instance
          .collection('location')
          .doc(location[i])
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> doc = documentSnapshot.data();
          caseNo = doc['caseNo'];
          riskLevel = doc['riskLevel'];
          coord = List.from(doc['coord']);
          print(location[i]);
          print(caseNo);
          print(riskLevel);
          for (var j = 0; j < coord.length; j++) {
            polygonLatLngs.add(LatLng(coord[j].latitude, coord[j].longitude));
          }
          print(polygonLatLngs);
          _polygons.add(
            Polygon(
              polygonId: PolygonId(i.toString()),
              points: polygonLatLngs,
              strokeWidth: 2,
              strokeColor: riskColors[riskLevel],
              fillColor: riskColors[riskLevel].withOpacity(0.15),
            ),
          );
          if (_checkIfValidMarker(myLocation, polygonLatLngs)) {
            setState(() {
              myRiskLevel = riskLevel;
              myCaseNo = caseNo;
            });
          }
        }
      });
    }
  }

  bool _checkIfValidMarker(LatLng location, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(location, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng location, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = location.latitude;
    double pX = location.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }

  //Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.86,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 10.0,
                offset: Offset(0.0, 3.0),
                color: Color.fromRGBO(0, 0, 0, 0.24))
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //search
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                width: 330,
                child: DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: [
                      'Taman Kampar Perdana',
                      'Taman Bandar Baru',
                      'Taman Bandar Baru Selatan',
                      'Kampung Masjid',
                      'Kampar Putra'
                    ],
                    label: "Select your location",
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                        for (var i = 0; i < location.length; i++) {
                          if (selectedValue == location[i]) {
                            print('selected = ' + location[i]);
                            myLocation = searchLocation[i];
                            getData();
                            _markers.clear();
                            _setMarkers(searchLocation[i]);

                            _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: myLocation,zoom:15.0)));
                          }
                        }
                      });
                    },
                    selectedItem: 'Choose a location'),
              ),
            ),
            Container(
                //map
                margin: EdgeInsets.all(5.0),
                width: 330.0,
                height: MediaQuery.of(context).size.height * 0.48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: myLocation,
                          zoom: 13.5,
                        ),
                        mapType: MapType.hybrid,
                        polygons: _polygons,
                        markers: _markers,
                        myLocationEnabled: true,
                        onTap: (point) {
                          setState(() {
                            _markers.clear();
                            myLocation = point;
                            getData();
                            _setMarkers(point);
                          });
                        }),
                  ],
                )),
            Container(
                //result for search region
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: riskColors[myRiskLevel], width: 4),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      children: [
                        Text(
                          "This location is under : ",
                        ),
                        Text(
                          riskLabels[myRiskLevel],
                          style: TextStyle(
                              color: riskColors[myRiskLevel],
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))),
            Container(
              //result for current location
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 3.0),
                        color: Color.fromRGBO(0, 0, 0, 0.24))
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    width: 60.0,
                    height: 60.0,
                    child: FittedBox(
                      child: Image.network(riskimage[myRiskLevel]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final doc = snapshot.data;
                          return Container(
                              width: 220.0,
                              child: Text(
                                  "Hi, ${doc['name']}, there have been " +
                                      myCaseNo.toString() +
                                      " reported case(s) of covid-19 within a 1 km radius from this location in the last 14 days.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0)));
                        }
                        return Text('no data');
                      })
                ],
              ),
            )
          ]),
    );
  }
}
