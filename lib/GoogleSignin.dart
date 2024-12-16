import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Googlesignin extends StatelessWidget {
  const Googlesignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: const CircleAvatar(
          radius: 17,
          backgroundImage: AssetImage('assets/google.png'),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
