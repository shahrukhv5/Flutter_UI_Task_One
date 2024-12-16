import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigup_sigin_ui/Home.dart';
import 'package:sigup_sigin_ui/SignUp.dart';
import 'package:sigup_sigin_ui/SplashScreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true; // For Password field
  bool _isChecked = false; // Tracks the checkbox state
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Form(
                key: _formKey, // Attach the form key
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage('assets/signinbg.png'),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in to',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Sync',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF93ABFF)),
                        )
                      ],
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    Column(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordHidden,
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                }),
                            const Text(
                              "Remember me",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            const Text(
                              "Forgot password?",
                              style: TextStyle(
                                  color: Colors.blue, // Blue color for link
                                  fontSize: 20, // Adjust size as needed
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Colors.blue // Bold for emphasis
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Add async here
                        if (_formKey.currentState!.validate()) {
                          final user =
                              await GoogleSignInApi.login(); // Use await here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                fullname: "",
                                email: _emailController.text,
                                user: user,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF93ABFF),
                        // Light blue color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30.0), // Rounded edges
                        ),
                        minimumSize:
                            const Size(400, 50), // Button size (width x height)
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 25.0, // Text size
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.blue, // Blue color for link
                                fontSize: 20, // Adjust size as needed
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Colors.blue // Bold for emphasis
                                ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Or Continue with',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: signIn,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage('assets/google.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage('assets/facebook.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 14,
                            backgroundImage: AssetImage('assets/apple.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skip now',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 15,
                          color: Colors.blue,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sign-in Failed")));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(
            fullname: "",
            email: _emailController.text,
            user: user,
          ),
        ),
      );
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(SplashscreenState.KEYLOGIN, true);
    }
  }
}
