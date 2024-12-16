// import 'package:flutter/material.dart';
// import 'package:sigup_sigin_ui/Home.dart';
// import 'package:sigup_sigin_ui/SplashScreen.dart';
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     initialRoute: 'splashScreen',
//     routes: {
//       'splashScreen': (context) => const Splashscreen(),
//       'home': (context) => const Home(
//             fullname: '',
//             email: '',
//             user: {},
//           ),
//     },
//   ));
// }
import 'package:flutter/material.dart';
import 'package:sigup_sigin_ui/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashScreen',
    routes: {
      'splashScreen': (context) => const Splashscreen(),
    },
  ));
}
