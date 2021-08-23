import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UpdateNews extends StatefulWidget {
  static const routeName = '/updatenews';

  @override
  _UpdateNewsState createState() => _UpdateNewsState();
}

class _UpdateNewsState extends State<UpdateNews> {
  File _pickedImage;
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController captioncontroller = TextEditingController();

  void _showdialog(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) {
        return Container(
          height: 120,
          child: ListView(
            children: [
              TextButton.icon(
                  onPressed: _pickImageCamera,
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              Divider(),
              TextButton.icon(
                  onPressed: _pickImageGallery,
                  icon: Icon(Icons.album),
                  label: Text('Gallery')),
            ],
          ),
        );
      },
    );
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    Navigator.pop(context);
  }

  Future uploadData() async {
    String caption = captioncontroller.text;

    final imageStorage = FirebaseStorage.instance
        .ref()
        .child('news')
        .child(DateTime.now().toString() + '.jpg');

    await imageStorage.putFile(_pickedImage);
    final url = await imageStorage.getDownloadURL();

    return FirebaseFirestore.instance.collection('news').add({
      'imageUrl': url,
      'caption': caption,
      'time': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update News'),
        actions: [
          TextButton(
              onPressed: () {
                uploadData();
                Navigator.pop(context);
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Caption',
                      hintText: 'Please enter the caption here',
                    ),
                    controller: captioncontroller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Image :',
                            style: TextStyle(fontSize: 15),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 440,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: _pickedImage != null
                              ? DecorationImage(
                                  image: FileImage(_pickedImage),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: NetworkImage(
                                      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg'),
                                  fit: BoxFit.cover),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _showdialog(context);
                        },
                        icon: Icon(
                          Icons.image,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Upload Image",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
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
