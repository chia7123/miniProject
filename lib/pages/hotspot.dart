import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:myselamat/widgets/mapcard.dart';

class Hotspot extends StatelessWidget {
  final LocationData locationData;
  Hotspot(this.locationData);

  static const routename = '/hotspot';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotspot'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MapCard(
              location: locationData,
            ),
          )
        ],
      ),
    );
  }
}
