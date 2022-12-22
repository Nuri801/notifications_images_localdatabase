
// import 'dart:html'
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  var _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final _picker = ImagePicker();
                // Pick an image
                final image = await _picker.pickImage(source: ImageSource.gallery);
                if(image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              child: Text('pick an image'),
            ),
            ElevatedButton(
              onPressed: () async {
                final _picker = ImagePicker();
                // Pick an image
                final image = await _picker.pickImage(source: ImageSource.camera);
                if(image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                }
              },
              child: Text('camera image'),
            ),
            _image == null ? Text('no images here') : Image.file(_image),
          ],
        ),
      ),
    );
  }
}
