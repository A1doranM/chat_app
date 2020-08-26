import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage: _image == null
              ? AssetImage('assets/default_avatar.png')
              : FileImage(_image),
        ),
        FlatButton.icon(
          onPressed: pickImage,
          icon: Icon(Icons.camera),
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
