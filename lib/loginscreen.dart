import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tatto_webapp/mainscreen.dart';
import 'package:tatto_webapp/registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('User ${userCredential.user?.email} is logged in');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
    } catch (e) {
      print("Sign in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign in failed. Please check your credentials.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/dragon.jpg'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1), // Adjust opacity as needed
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tattoo',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'CinzelDecorative',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ARTIST',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'CinzelDecorative',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Please sign in to continue.'),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => signIn(context),
                icon: Icon(Icons.login), // Icon for the button
                label: Text(
                  'LOGIN',
                  style:
                      TextStyle(fontSize: 16), // Text style for the button text
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black, // Text color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25), // Rounded button corners
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 20), // Button padding
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
