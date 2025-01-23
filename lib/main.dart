import 'package:flutter/material.dart';
import 'package:sigup_sigin_ui/SplashScreen/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashScreen',
    routes: {
      'splashScreen': (context) => const Splashscreen(),
    },
  ));
}
