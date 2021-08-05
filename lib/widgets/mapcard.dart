import 'dart:collection';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapCard extends StatefulWidget {
  final LocationData location;
  static var riskColors = [Colors.green, Colors.orange, Colors.red];
  static var riskLabels = ["LOW RISK", "MEDIUM RISK", "HIGH RISK"];
  static var riskimage = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flat_tick_icon.svg/768px-Flat_tick_icon.svg.png",
    "https://img.icons8.com/ios-filled/452/low-risk.png",
    "https://icon-library.com/images/high-risk-icon/high-risk-icon-0.jpg",
  ];

  MapCard({@required this.location});

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  List<DropdownMenuItem> items = [];
  String selectedValue = '';

  String _previewImageUrl = '';

  LocationData _locationData;

  // Maps
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Circle> _circles = HashSet<Circle>();
  GoogleMapController _googleMapController;
  BitmapDescriptor _markerIcon;

  //firestore
  List<String> location = [
    'Taman Kampar Perdana',
    'Taman Bandar Baru',
    'Taman Bandar Baru Selatan'
  ];
  var caseno;
  var riskLevel;
  List<GeoPoint> coord;

  @override
  void initState() {
    super.initState();
    // If I want to change the marker icon:
    // _setMarkerIcon();
    _locationData = widget.location;
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
          caseno = doc['caseNo'];
          riskLevel = doc['riskLevel'];
          coord = List.from(doc['coord']);
          print(location[i]);
          print(caseno);
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
              strokeColor: Colors.yellow,
              fillColor: Colors.yellow.withOpacity(0.15),
            ),
          );
        }
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
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
      child: SingleChildScrollView(
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
                      'Tapah',
                      'Ipoh',
                      'Lumut',
                      'Manjung',
                      'Kinta',
                      'Kuala Kangsar',
                      'Taiping',
                      'Batu Gajah',
                      'Teluk Intan',
                      'Kampar'
                    ],
                    label: "Select your location",
                    // popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                    selectedItem: 'Choose a location'),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   height: 190,
            //   width: double.infinity,
            //   child: _previewImageUrl == ''
            //       ? Column(
            //           children: [
            //             Text(
            //               '*Use your current location or search a location to check for COVID-19 hotspot',
            //               style: TextStyle(color: Colors.grey),
            //               softWrap: true,
            //             ),
            //             Container(
            //               height: 100,
            //               decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                       image: NetworkImage(
            //                           'https://thumbs.dreamstime.com/b/black-map-geo-location-navigation-pin-icon-driving-black-map-geo-location-navigation-pin-icon-white-background-180950811.jpg'))),
            //             ),
            //             Text(
            //               'To view map, kindly use search box to search for a location',
            //               style: TextStyle(color: Colors.grey),
            //               softWrap: true,
            //             ),
            //           ],
            //         )
            //       : Image.network(
            //           _previewImageUrl,
            //           fit: BoxFit.cover,
            //           width: double.infinity,
            //         ),
            // ),

            Container(
                //map
                margin: EdgeInsets.all(5.0),
                width: 330.0,
                height: MediaQuery.of(context).size.height * 0.68,
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
                        target: LatLng(
                            _locationData.latitude, _locationData.longitude),
                        zoom: 16,
                      ),
                      mapType: MapType.hybrid,
                      polygons: _polygons,
                      myLocationEnabled: true,
                    ),
                  ],
                )),
            Container(
                //result for search region
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: MapCard.riskColors[0], width: 4),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      children: [
                        Text(
                          "This location is under : ",
                        ),
                        Text(
                          MapCard.riskLabels[0],
                          style: TextStyle(
                              color: MapCard.riskColors[0],
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
                      child: Image.network(MapCard.riskimage[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      width: 220.0,
                      child: Text(
                          "Hi, Barry, there have been no reported case(s) of covid-19 within a 1 km radius from your current location in the last 14 days.",
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.0)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
