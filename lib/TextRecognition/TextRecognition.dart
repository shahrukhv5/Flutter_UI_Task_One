import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                color: Colors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFF93ABFF),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 50.h),
          pickedImage == null
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 400.h,
                    child: const Center(
                      child: Text("No Image Selected"),
                    ),
                  ),
                )
              : Center(
                  child: Image.file(
                    File(pickedImage!.path),
                    height: 400.h,
                  ),
                ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.photo,
                  color: Color(0xFF93ABFF),
                ),
                label: const Text(
                  "Gallery",
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.photo_camera, color: Color(0xFF93ABFF)),
                label: const Text(
                  "camera",
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Center(
            child: Text(
              "Recognition Text:",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30.h),
          scanning
              ? Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                      size: 20.sp,
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
                        textStyle: TextStyle(fontSize: 20.sp),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
