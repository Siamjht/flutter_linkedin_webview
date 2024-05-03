


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'uint8list_image_view.dart';

class LinkedInWebView extends StatefulWidget {

  @override
  State<LinkedInWebView> createState() => _LinkedInWebViewState();
}

class _LinkedInWebViewState extends State<LinkedInWebView> {
  final ScreenshotController screenshotController = ScreenshotController();
  late final WebViewController controller;


  Future<Uint8List?> captureAndSaveImage() async{
    final Uint8List? uint8list = await screenshotController.capture();
    print("Uint8list:============>>> $uint8list");
    return uint8list;
    if(uint8list != null){

      // final PermissionStatus status = await Permission.storage.request();
      // if(status.isGranted){
      //   final result = await ImageGallerySaver.saveImage(uint8list);
      //   if(result['isSuccess']){
      //     print("Success:============>>> Image saved");
      //   }else{
      //     print("Failure: ===========>>> ${result['error']}");
      //   }
      // }else {
      //   print("Permission to access is denied");
      // }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.linkedin.com/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LinkedIn'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: WebViewWidget(
            controller: controller
        ),
        // child: WebView(
        //   initialUrl: 'https://www.linkedin.com/',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await captureAndSaveImage().then((value) => Get.to(ImageDisplayWidget(imageData: value!,)));
      },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}