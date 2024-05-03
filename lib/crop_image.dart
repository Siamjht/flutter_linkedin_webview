
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class CropImageScreen extends StatefulWidget {
  final File imagePath;

  CropImageScreen({required this.imagePath});

  @override
  _CropImageScreenState createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  File? _imageFile;

  Future<void> _cropImage() async {
    print("Image Path: ${widget.imagePath.toString()}");
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.imagePath.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Cropper Demo'),
      ),
      body: Center(
        child: _imageFile != null
            ? Image.file(_imageFile!)
            : Text('No image selected'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _cropImage();
        },
        tooltip: 'Crop Image',
        child: Icon(Icons.crop),
      ),
    );
  }
}
