

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'uint8list_to_file_convertion.dart';

class ImageDisplayWidget extends StatelessWidget {
  final Uint8List imageData;

  ImageDisplayWidget({required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uint8List Image Display'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Image.memory(
              imageData,
              // You can specify width and height constraints if needed
              width: 250,
              height: 350,
              fit: BoxFit.fill, // Adjust the fit as needed
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              Get.to(Uint8ListToFileImage(imageBytes: imageData,));
            }, child: Text("Tap to get file image")),
          ],
        ),
      ),
    );
  }
}
