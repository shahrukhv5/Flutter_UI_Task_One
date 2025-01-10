import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognition extends StatefulWidget {
  const TextRecognition({super.key});

  @override
  State<TextRecognition> createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  XFile? pickedImage;
  String mytext = '';
  bool scanning = false;

  final ImagePicker _imagePicker = ImagePicker();

  getImage(ImageSource ourSource) async {
    XFile? result = await _imagePicker.pickImage(source: ourSource);

    if (result != null) {
      setState(() {
        pickedImage = result;
      });
      performTextRecognition();
    }
  }

  performTextRecognition() async {
    setState(() {
      scanning = true;
    });
    try {
      final inputImage = InputImage.fromFilePath(pickedImage!.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final recognizeText = await textRecognizer.processImage(inputImage);

      setState(() {
        mytext = recognizeText.text;
        scanning = false;
      });
      textRecognizer.close();
    } catch (e) {
      print("Error during text recognition: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Text Recognition",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFF93ABFF),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 50),
          pickedImage == null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 400,
                    child: Center(
                      child: Text("No Image Selected"),
                    ),
                  ),
                )
              : Center(
                  child: Image.file(
                    File(pickedImage!.path),
                    height: 400,
                  ),
                ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.photo,
                  color: Color(0xFF93ABFF),
                ),
                label: Text(
                  "Gallery",
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.photo_camera, color: Color(0xFF93ABFF)),
                label: Text(
                  "camera",
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Recognition Text:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          scanning
              ? Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )
              : Center(
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        mytext,
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
