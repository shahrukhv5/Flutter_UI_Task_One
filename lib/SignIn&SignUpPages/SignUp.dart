import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigup_sigin_ui/HomePage/Home.dart';
import 'package:sigup_sigin_ui/SignIn&SignUpPages/SignIn.dart';
import 'package:sigup_sigin_ui/SplashScreen/SplashScreen.dart';

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
              padding: EdgeInsets.fromLTRB(20.0.w, 0.0.h, 20.0.w, 0.0.h),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign up to',
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          'Sync',
                          style: TextStyle(
                              fontSize: 25.sp,
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
                    SizedBox(height: 40.h),
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
                          borderRadius: BorderRadius.circular(30.0.r),
                        ),
                        minimumSize: Size(400.w, 50.h),
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    _buildSignInPrompt(),
                    SizedBox(height: 40.h),
                    _buildSocialLogins(),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Skip now',
                          style: TextStyle(fontSize: 18.sp, color: Colors.blue),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 15.sp,
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
        Text(
          'Already have an account?',
          style: TextStyle(color: Colors.grey, fontSize: 20.sp),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignIn()));
          },
          child: Text(
            "Sign in",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 20.sp,
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
        Text(
          'Or Continue with',
          style: TextStyle(color: Colors.grey, fontSize: 18.sp),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: signIn,
          child: CircleAvatar(
            radius: 17.r,
            backgroundImage: AssetImage('assets/google.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 17.r,
            backgroundImage: AssetImage('assets/facebook.png'),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 14.r,
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
