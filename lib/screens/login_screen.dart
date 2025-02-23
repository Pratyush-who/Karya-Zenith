import 'package:flutter/material.dart';
import 'package:todoapp/firebase/services/auth_services.dart';
import 'package:todoapp/screens/HomeScreen.dart';
import 'package:todoapp/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2E1437).withOpacity(0.9), // Deep purple
                      Color(0xFF0A0E21).withOpacity(0.95), // Dark blue-black
                    ],
                  ),
                ),
              ),
              SafeArea(
                //SafeArea is a widget that helps prevent UI elements from being obscured by system overlays such as the status bar, notch, navigation bar, or other device-specific cutouts
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF9C27B0), 
                                    Color(0xFF673AB7), 
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF9C27B0).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.check_circle_outline,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Karya Zenith',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                              ),
                            ),
                            Text(
                              'Take your tasks to the Zenith',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),

                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Color(
                            0xFF1A1F38,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.purple.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 24),
                            TextField(
                              controller: _emailController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white60),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF9C27B0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.white24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xFF9C27B0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _passwordController,
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white60),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF9C27B0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.white24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xFF9C27B0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.05),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () async {
                                  var user = await _auth
                                      .signInWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text,
                                      );

                                  if (user != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Homescreen(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF9C27B0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 8,
                                  shadowColor: Color(
                                    0xFF9C27B0,
                                  ).withOpacity(0.5),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Spacer(),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "New to Karya Zenith? ",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Create Account',
                                  style: TextStyle(
                                    color: Color(0xFF9C27B0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
