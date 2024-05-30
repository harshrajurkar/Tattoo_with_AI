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

void initState() {
  super.initState();
  // Check if the user is already authenticated when the screen initializes
  checkAuthStatus();
}Future<void> checkAuthStatus() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    // If user is already logged in, navigate to the main screen
    print('User ${user.email} is already logged in');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
  }
}

  Future<void> signIn(BuildContext context) async {
    try {
           
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // If successful, print the statement and navigate to the main screen
      print('User ${userCredential.user?.email} is logged in');
      
      // Uncomment the following line if you want to navigate to the main screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
    } catch (e) {
      // Handle sign-in errors
      print("Sign in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign in failed. Please check your credentials.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => signIn(context),
              child: Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
