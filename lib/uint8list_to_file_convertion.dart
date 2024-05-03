import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import 'crop_image.dart';

class Uint8ListToFileImage extends StatefulWidget {
  final Uint8List imageBytes;

  Uint8ListToFileImage({required this.imageBytes});

  @override
  _Uint8ListToFileImageState createState() => _Uint8ListToFileImageState();
}

class _Uint8ListToFileImageState extends State<Uint8ListToFileImage> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _convertAndSaveImage();
  }

  Future<void> _convertAndSaveImage() async {
    final file = await DefaultCacheManager().putFile(
      'profile_image.jpg',
      widget.imageBytes,
    );
    print("image path: $file");
    setState(() {
      _imageFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uint8List to File Image'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              height: 350,
                width: 250,
                child: _imageFile != null
                ? Image.file(_imageFile!, fit: BoxFit.fill,)
                : CircularProgressIndicator(),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              Get.to(CropImageScreen(imagePath: _imageFile!,));
            }, child: Text("Tap to crop image")),
          ],
        ),
      ),
    );
  }
}
