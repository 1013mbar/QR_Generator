import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//import 'package:image/image.dart' as img;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  String qrData = '1312';

  final screenshotController = ScreenshotController();



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Screenshot(

              controller: screenshotController,

              child: QrImageView(

                data: qrData,

                version: QrVersions.auto,

                size: 200.0,

                backgroundColor: Colors.white,

              ),

            ),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20.0),

              child: TextField(

                onChanged: (value) {

                  setState(() {

                    qrData = value;

                  });

                },

                decoration: InputDecoration(

                  hintText: "Enter QR data",

                  border: OutlineInputBorder(),

                ),

              ),

            ),

            ElevatedButton(

              onPressed: () async {

                final image = await screenshotController.capture();

                if (image != null) {

                  final pngImage = XFile.fromData(image, mimeType: 'image/png');

                  await Share.shareXFiles([pngImage]);

                }

              },

              style: ButtonStyle(

                backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set your desired color

                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),

              child: Text('Share QR Code'),

            ),

          ],

        ),

      ),


    );

  }

}
