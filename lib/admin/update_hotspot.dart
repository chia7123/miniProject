import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:myselamat/main.dart';

class UpdateHotspot extends StatefulWidget {
  const UpdateHotspot({Key key}) : super(key: key);

  @override
  _UpdateHotspotState createState() => _UpdateHotspotState();
}

class _UpdateHotspotState extends State<UpdateHotspot> {
  String selectedValue;
  List<String> location = [
    'Taman Kampar Perdana',
    'Taman Bandar Baru',
    'Taman Bandar Baru Selatan',
    'Kampung Masjid',
    'Kampar Putra'
  ];

  Future<void> updateHotspotData(int caseNo, int riskLevel) {
    // Call the user's CollectionReference to add a new user
    return FirebaseFirestore.instance
        .collection('location')
        .doc(selectedValue)
        .update({
      'caseNo': caseNo,
      'riskLevel': riskLevel,
    }).then((value) => print("location updated"));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController caseNo = TextEditingController();
    TextEditingController riskLevel = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Hotspot'),
      ),
      body: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  width: 330,
                  child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      showSelectedItem: true,
                      items: location,
                      label: "Select your location",
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                        });
                      },
                      selectedItem: 'Choose a location'),
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'No of Cases:'),
                controller: caseNo,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Risk Level:'),
                controller: riskLevel,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateHotspotData(
                        int.parse(caseNo.text), int.parse(riskLevel.text));
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
