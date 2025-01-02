import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CardWithImageAndText(),
      ),
    );
  }
}

class CardWithImageAndText extends StatelessWidget {
  const CardWithImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          // Image background
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              'https://images.unsplash.com/flagged/1/apple-gear-looking-pretty.jpg?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          // Text on image
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              'Your Text Here',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
