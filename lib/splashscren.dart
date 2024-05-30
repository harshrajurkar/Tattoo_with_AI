import 'package:flutter/material.dart';
import 'package:tatto_webapp/loginscreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to LoginScreen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background container with the dragon image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('dragon.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), // Add whitish tint
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          // Text positioned at the center of the screen
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tattoo',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Jarohy', // Use Jarohy font
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
                Text(
                  'ARTIST',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Jarohy', // Use Jarohy font
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
