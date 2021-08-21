//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myselamat/widgets/checkin.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io' as Platform;

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode barcode;
  String userID;

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.Platform.isAndroid) {
      await controller.pauseCamera();
    } else {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQRView(context),
            Positioned(
              child: buildResult(),
              bottom: 40,
            )
          ],
        ),
      ));

  Widget buildResult() => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white24,
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode.code}' : 'Scan a QR code',
          maxLines: 4,
        ),
      );

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderLength: 20,
          borderWidth: 10,
          borderRadius: 10,
          borderColor: Color(0xff5098fe),
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) async {
    setState(() => this.controller = controller);

    int existingIndex;

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('travel history')
        .get()
        .then((QuerySnapshot querySnapshot) {
      existingIndex = querySnapshot.docs.length;
    });

    controller.scannedDataStream.listen((barcode) async {
      await controller.pauseCamera();
      this.barcode = barcode;

      var now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String dateNow = formatter.format(now);
      userID = FirebaseAuth.instance.currentUser.uid;
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection("users");
      final String timeNow = (now.hour.toString() +
          ":" +
          now.minute.toString() +
          ":" +
          now.second.toString());

      await usersCollection.doc(userID).collection('travel history').add({
        "id": existingIndex == null ? 0 : existingIndex,
        "place": '${barcode.code}',
        "time": timeNow,
        "date": dateNow
      });
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckIn(
                  date: dateNow, time: timeNow, location: barcode.code)));
    });
  }
}
