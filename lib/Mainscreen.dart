import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _searchQuery = '';
  bool _isTattooOnBody = false;
  List<String> _filteredImages = [];

  // Method to fetch images from Unsplash based on the search query
  Future<List<String>> fetchImagesFromUnsplash(String query) async {
    final String accessKey = '_OtXt-IeY0ZA8Ry4nwvslWbMeRZ8cvjFS_m6Z8yDH7A'; // Replace with your Unsplash API access key
    final String url = 'https://api.unsplash.com/search/photos?query=$query&client_id=$accessKey';
    
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<String> imageUrls = data.map((e) => e['urls']['regular'] as String).toList();
      return imageUrls;
    } else {
      throw Exception('Failed to load images');
    }
  }

  // Callback method to update the search query
  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  // Callback method to toggle the "Tattoo on Body" switch
  void _toggleTattooOnBody(bool newValue) {
    setState(() {
      _isTattooOnBody = newValue;
    });
  }

  // Method to fetch and filter images based on the search query and "Tattoo on Body" switch
  Future<void> _fetchAndFilterImages() async {
    if (_searchQuery.isNotEmpty) {
      // Fetch images from Unsplash based on search query
      List<String> fetchedImages = await fetchImagesFromUnsplash(_searchQuery);
      setState(() {
        _filteredImages = fetchedImages;
      });
    } else {
      setState(() {
        _filteredImages.clear();
      });
    }
  }

  // Method to generate tattoos
  void _generateTattoos() {
    _fetchAndFilterImages();
  }

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
            TextField(
              onChanged: _updateSearchQuery,
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
                  onChanged: _toggleTattooOnBody,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Tattoo Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: _filteredImages.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            // Button to generate tattoos
            ElevatedButton(
              onPressed: _generateTattoos,
              child: Text('Generate Tattoos'),
            ),
          ],
        ),
      ),
    );
  }
}
