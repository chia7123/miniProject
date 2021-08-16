import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'dart:io' show Platform;

class ScanPage extends StatefulWidget {

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  void dispose(){
    controller?.dispose();
    super.dispose();  
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller.pauseCamera();
    } else  {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
  child: Scaffold(
  body: Stack(alignment: Alignment.center,children: <Widget>[
  buildQRView(context),
  ],),)
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

  void onQRViewCreated(QRViewController controller){
  setState(() => this.controller = controller);
  }
}