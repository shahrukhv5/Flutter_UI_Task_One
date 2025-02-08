import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigup_sigin_ui/SplashScreen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
  //     MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   initialRoute: 'splashScreen',
  //   routes: {
  //     'splashScreen': (context) => const Splashscreen(),
  //   },
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 1000),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splashScreen',
        routes: {
          'splashScreen': (context) => const Splashscreen(),
        },
      ),
    );
  }
}
