import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigup_sigin_ui/Home.dart';
import 'package:sigup_sigin_ui/SignIn.dart';
import 'package:sigup_sigin_ui/SplashScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordHidden = true; // For Password field
  bool _isConfirmPasswordHidden = true; // For Confirm Password field

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        image: AssetImage('assets/signupbg.png'),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign up to',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Sync',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF93ABFF)),
                        )
                      ],
                    ),
                    // Full Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: "Full name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    // Email Field
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
                    // Password Fields
                    _buildPasswordFields(),
                    const SizedBox(height: 40),
                    //Sign Up Button
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
                                fullname: _nameController.text,
                                email: _emailController.text,
                                user: user,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF93ABFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(400, 50),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildSignInPrompt(),
                    const SizedBox(height: 40),
                    _buildSocialLogins(),
                    const SizedBox(height: 20),
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
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        // Password Field
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
                _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
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
        // Confirm Password Field
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _isConfirmPasswordHidden,
          decoration: InputDecoration(
            labelText: "Confirm password",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                });
              },
              icon: Icon(
                _isConfirmPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignIn()));
          },
          child: const Text(
            "Sign in",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Or Continue with',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: signIn,
          child: const CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage('assets/google.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            radius: 17,
            backgroundImage: AssetImage('assets/facebook.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage('assets/apple.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
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
            fullname: _nameController.text,
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

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
