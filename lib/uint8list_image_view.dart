

import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageDisplayWidget extends StatelessWidget {
  final Uint8List imageData;

  ImageDisplayWidget({required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display'),
      ),
      body: Center(
        child: Image.memory(
          imageData,
          // You can specify width and height constraints if needed
          width: 250,
          height: 350,
          fit: BoxFit.fill, // Adjust the fit as needed
        ),
      ),
    );
  }
}
