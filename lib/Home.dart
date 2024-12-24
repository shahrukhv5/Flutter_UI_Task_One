import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigup_sigin_ui/ApiDataPage.dart';
import 'package:sigup_sigin_ui/SignIn.dart';
import 'package:sigup_sigin_ui/SignUp.dart';
import 'package:sigup_sigin_ui/SplashScreen.dart';

class Home extends StatelessWidget {
  final String fullname;
  final String email;
  final GoogleSignInAccount? user; // Make this nullable

  const Home({
    Key? key,
    required this.fullname,
    required this.email,
    this.user, // Make this nullable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93ABFF),
        title: const Text("Logged In"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(SplashscreenState.KEYLOGIN, false);
              await GoogleSignInApi.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignIn()),
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            // Show a placeholder image if user.photoUrl is null
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user?.photoUrl ??
                  'https://via.placeholder.com/150'), // Placeholder if null
            ),
            const SizedBox(height: 8),
            Text(
              "Hello, ${user?.displayName ?? "Guest"}",
              // Handle null displayName
              style: const TextStyle(
                color: Color(0xFF93ABFF),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Email: ${user?.email ?? email}",
              // Fallback to email if user is null
              style: const TextStyle(
                color: Color(0xFF93ABFF),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ApiDataPage()));
                // MaterialPageRoute(builder: (context) => PerformanceCard()));
              },
              child: Text(
                "Click here",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF93ABFF)),
            )
          ],
        ),
      ),
    );
  }
}
