import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> tattoos = [
    'tatto1.jpg',
    'tatto1.jpg',
    'tatto1.jpg',
    'tatto1.jpg'
  ];
  bool _isTattooOnBody = false;
  List<String> _selectedBodyParts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Your Tattoo Using AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Text(
              'Tattoo List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(tattoos[index % tattoos.length]),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your tattoo prompt',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tattoo on Body'),
                Switch(
                  value: _isTattooOnBody,
                  onChanged: (value) {
                    setState(() {
                      _isTattooOnBody = value;
                      _selectedBodyParts.clear();
                    });
                  },
                ),
              ],
            ),
            // Wrap the checkbox list with Visibility widget
            Visibility(
              visible: _isTattooOnBody,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Select Body Parts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ..._buildBodyPartCheckboxes(),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tattoo With AI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBodyPartCheckboxes() {
    return _selectedBodyParts.map((part) {
      return CheckboxListTile(
        title: Text(part),
        value: _selectedBodyParts.contains(part),
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              _selectedBodyParts.add(part);
            } else {
              _selectedBodyParts.remove(part);
            }
          });
        },
      );
    }).toList();
  }
}
