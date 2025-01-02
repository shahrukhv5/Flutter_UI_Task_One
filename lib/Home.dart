import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GalleryPage.dart';
import 'ApiDataPage.dart';
import 'Profile.dart';
import 'CustomBottomNavBar.dart';
import 'SignIn.dart';

class Home extends StatefulWidget {
  final String fullname;
  final String email;
  final GoogleSignInAccount? user;

  const Home({
    Key? key,
    required this.fullname,
    required this.email,
    this.user,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      buildHomeContent(),
      const GalleryPage(),
      const ApiDataPage(),
      const Profile(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 // Show AppBar only on the Home page
          ? AppBar(
              backgroundColor: const Color(0xFF93ABFF),
              title: const Text(
                'Home',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () async {
                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool('KEYLOGIN', false);
                    await GoogleSignIn().signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: const Text("Logout",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          : null, // No AppBar for other pages
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget buildHomeContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              widget.user?.photoUrl ?? 'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Hello, ${widget.user?.displayName ?? "Guest"}",
            style: const TextStyle(
              color: Color(0xFF93ABFF),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            "Email: ${widget.user?.email ?? widget.email}",
            style: const TextStyle(
              color: Color(0xFF93ABFF),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
