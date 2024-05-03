import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'uint8list_image_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LinkedInWebView(),
    );
  }
}

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


///<<<===========================================
// import 'dart:io';
//
// import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(BaseflowPluginExample(
//       pluginName: 'Permission Handler',
//       githubURL: 'https://github.com/Baseflow/flutter-permission-handler',
//       pubDevURL: 'https://pub.dev/packages/permission_handler',
//       pages: [PermissionHandlerWidget.createPage()]));
// }
//
// ///Defines the main theme color
// final MaterialColor themeMaterialColor =
// BaseflowPluginExample.createMaterialColor(
//     const Color.fromRGBO(48, 49, 60, 1));
//
// /// A Flutter application demonstrating the functionality of this plugin
// class PermissionHandlerWidget extends StatefulWidget {
//   /// Create a page containing the functionality of this plugin
//   static ExamplePage createPage() {
//     return ExamplePage(
//         Icons.location_on, (context) => PermissionHandlerWidget());
//   }
//
//   @override
//   _PermissionHandlerWidgetState createState() =>
//       _PermissionHandlerWidgetState();
// }
//
// class _PermissionHandlerWidgetState extends State<PermissionHandlerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//           children: Permission.values
//               .where((permission) {
//             if (Platform.isIOS) {
//               return permission != Permission.unknown &&
//                   permission != Permission.phone &&
//                   permission != Permission.sms &&
//                   permission != Permission.ignoreBatteryOptimizations &&
//                   permission != Permission.accessMediaLocation &&
//                   permission != Permission.activityRecognition &&
//                   permission != Permission.manageExternalStorage &&
//                   permission != Permission.systemAlertWindow &&
//                   permission != Permission.requestInstallPackages &&
//                   permission != Permission.accessNotificationPolicy &&
//                   permission != Permission.bluetoothScan &&
//                   permission != Permission.bluetoothAdvertise &&
//                   permission != Permission.bluetoothConnect &&
//                   permission != Permission.nearbyWifiDevices &&
//                   permission != Permission.videos &&
//                   permission != Permission.audio &&
//                   permission != Permission.scheduleExactAlarm &&
//                   permission != Permission.sensorsAlways;
//             } else {
//               return permission != Permission.unknown &&
//                   permission != Permission.mediaLibrary &&
//                   permission != Permission.photosAddOnly &&
//                   permission != Permission.reminders &&
//                   permission != Permission.bluetooth &&
//                   permission != Permission.appTrackingTransparency &&
//                   permission != Permission.criticalAlerts &&
//                   permission != Permission.assistant;
//             }
//           })
//               .map((permission) => PermissionWidget(permission))
//               .toList()),
//     );
//   }
// }
//
// /// Permission widget containing information about the passed [Permission]
// class PermissionWidget extends StatefulWidget {
//   /// Constructs a [PermissionWidget] for the supplied [Permission]
//   const PermissionWidget(this._permission);
//
//   final Permission _permission;
//
//   @override
//   _PermissionState createState() => _PermissionState(_permission);
// }
//
// class _PermissionState extends State<PermissionWidget> {
//   _PermissionState(this._permission);
//
//   final Permission _permission;
//   PermissionStatus _permissionStatus = PermissionStatus.denied;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _listenForPermissionStatus();
//   }
//
//   void _listenForPermissionStatus() async {
//     final status = await _permission.status;
//     setState(() => _permissionStatus = status);
//   }
//
//   Color getPermissionColor() {
//     switch (_permissionStatus) {
//       case PermissionStatus.denied:
//         return Colors.red;
//       case PermissionStatus.granted:
//         return Colors.green;
//       case PermissionStatus.limited:
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         _permission.toString(),
//         style: Theme.of(context).textTheme.bodyLarge,
//       ),
//       subtitle: Text(
//         _permissionStatus.toString(),
//         style: TextStyle(color: getPermissionColor()),
//       ),
//       trailing: (_permission is PermissionWithService)
//           ? IconButton(
//           icon: const Icon(
//             Icons.info,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             checkServiceStatus(
//                 context, _permission as PermissionWithService);
//           })
//           : null,
//       onTap: () {
//         requestPermission(_permission);
//       },
//     );
//   }
//
//   void checkServiceStatus(
//       BuildContext context, PermissionWithService permission) async {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text((await permission.serviceStatus).toString()),
//     ));
//   }
//
//   Future<void> requestPermission(Permission permission) async {
//     final status = await permission.request();
//
//     setState(() {
//       print(status);
//       _permissionStatus = status;
//       print(_permissionStatus);
//     });
//   }
// }
