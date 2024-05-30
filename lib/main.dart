// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Tattoo Generator',
//       home: TattooGenerator(),
//     );
//   }
// }

// class TattooGenerator extends StatefulWidget {
//   @override
//   _TattooGeneratorState createState() => _TattooGeneratorState();
// }

// class _TattooGeneratorState extends State<TattooGenerator> {
//   final TextEditingController _textController = TextEditingController();
//   String _generatedImageUrl = '';
//   String _errorMessage = '';
//   bool _isLoading = false;
//   bool _isTattooOnBody = false;
//   List<String> _selectedBodyParts = [];

//   final List<String> _bodyParts = [
//     'Shoulder',
//     'Back',
//     'Arm',
//     'Leg',
//     'Chest'
//   ];

//   Future<void> generateTattoo() async {
//     final String apiKey = 'sk-proj-GF92693UtMYXDkvYVCJBT3BlbkFJFfIkOOtUy21shuWI66FJ'; // Replace with your OpenAI API key
//     final String prompt = _textController.text.toString();

//     String fullPrompt = prompt;
//     if (_isTattooOnBody && _selectedBodyParts.isNotEmpty) {
//       fullPrompt += ' on ${_selectedBodyParts.join(', ')}';
//     }

//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//       _generatedImageUrl = '';
//     });

//     try {
//       final response = await http.post(
//         Uri.parse('https://api.openai.com/v1/images/generations'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $apiKey',
//         },
//         body: jsonEncode({
//           'prompt': fullPrompt,
//           'n': 1,
//           'size': '512x512',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         setState(() {
//           _generatedImageUrl = responseData['data'][0]['url'];
//         });
//       } else {
//         final errorData = jsonDecode(response.body);
//         setState(() {
//           _errorMessage = 'Error: ${errorData['error']['message']}';
//         });
//         print('Error generating tattoo: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'An error occurred: $e';
//       });
//       print('An error occurred: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tattoo Generator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Text input field for entering the prompt
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 labelText: 'Enter tattoo prompt',
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Tattoo on Body'),
//                 Switch(
//                   value: _isTattooOnBody,
//                   onChanged: (value) {
//                     setState(() {
//                       _isTattooOnBody = value;
//                       _selectedBodyParts.clear();
//                     });
//                   },
//                 ),
//               ],
//             ),
//             if (_isTattooOnBody) ..._bodyParts.map((part) {
//               return CheckboxListTile(
//                 title: Text(part),
//                 value: _selectedBodyParts.contains(part),
//                 onChanged: (bool? value) {
//                   setState(() {
//                     if (value == true) {
//                       _selectedBodyParts.add(part);
//                     } else {
//                       _selectedBodyParts.remove(part);
//                     }
//                   });
//                 },
//               );
//             }).toList(),
//             SizedBox(height: 16),
//             // Button to trigger tattoo generation
//             ElevatedButton(
//               onPressed: generateTattoo,
//               child: Text('Generate Tattoo'),
//             ),
//             SizedBox(height: 16),
//             // Display loading indicator
//             if (_isLoading)
//               Center(child: CircularProgressIndicator()),
//             // Display the generated tattoo image if available
//             if (_generatedImageUrl.isNotEmpty)
//               Image.network(_generatedImageUrl),
//             // Display error message if any
//             if (_errorMessage.isNotEmpty)
//               Text(
//                 _errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tatto_webapp/firebase_options.dart';
import 'package:tatto_webapp/splashscren.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tattoo Artist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
