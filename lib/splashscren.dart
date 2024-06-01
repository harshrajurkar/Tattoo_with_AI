import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tatto_webapp/loginscreen.dart';
import 'package:tatto_webapp/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Trigger animation after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _visible = true;
      });
      // Check authentication status after animation
      Future.delayed(Duration(milliseconds: 500), () {
        checkAuthStatus();
      });
    });
  }

  Future<void> checkAuthStatus() async {
    print("Checking authentication status...");
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // If user is already logged in, navigate to the main screen
        print('User ${user.email} is already logged in');
        navigateToNextScreen();
      } else {
        // If user is not logged in, navigate to the login screen
        print('User is not logged in');
        navigateToLoginScreen();
      }
    } catch (e) {
      print("Error checking authentication status: $e");
      // Navigate to the login screen in case of any errors
      navigateToLoginScreen();
    }
  }

  void navigateToNextScreen() {
    // Delay navigation to next screen by 900 milliseconds for transition effect
    Future.delayed(Duration(milliseconds: 900), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  void navigateToLoginScreen() {
    // Delay navigation to login screen by 900 milliseconds for transition effect
    Future.delayed(Duration(milliseconds: 900), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background container with the dragon image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/dragon.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.85), // Add whitish tint
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          // Animated text positioned at the center of the screen
          AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            top: _visible ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 800),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Text(
                      'Tattoo',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'Jarohy', // Use Jarohy font
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 800),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Text(
                      'ARTIST',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Jarohy', // Use Jarohy font
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 1200),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Text(
                      'Unleash Your Inner Art',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'CinzelDecorative',
                        color: Colors.black, // Subtle text color
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 1600),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Text(
                      'Transform your body into a canvas of expression',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'CinzelDecorative',
                        color: Colors.black, // Subtle text color
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
