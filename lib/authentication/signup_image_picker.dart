import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpImagePicker extends StatefulWidget {
  SignUpImagePicker(this.imagePickFn);
  final Function(File pickedImage) imagePickFn;
  @override
  _SignUpImagePickerState createState() => _SignUpImagePickerState();
}

class _SignUpImagePickerState extends State<SignUpImagePicker> {
  File _pickedImage;

  void _showdialog(BuildContext ctx) {
    showModalBottomSheet(
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
        });
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _pickedImage = File(pickedImage.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : NetworkImage('https://cdn.icon-icons.com/icons2/2643/PNG/512/male_boy_person_people_avatar_icon_159358.png'),
        ),
        TextButton.icon(
          onPressed: ()=>_showdialog(context),
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            "Upload Image",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
