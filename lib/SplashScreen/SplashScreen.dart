import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigup_sigin_ui/HomePage/Home.dart';
import 'package:sigup_sigin_ui/SignIn&SignUpPages/SignIn.dart';
import 'package:sigup_sigin_ui/SignIn&SignUpPages/SignUp.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Splash Screen",
            style: TextStyle(
                fontSize: 34.sp,
                color: Color(0xFF93ABFF),
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  void whereToGo() async {
    final user = await GoogleSignInApi.login();
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        fullname: "",
                        email: "",
                        user: user,
                      )));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SignIn()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      }
    });
  }
}
