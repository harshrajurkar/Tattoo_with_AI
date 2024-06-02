import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tatto_webapp/loginscreen.dart';
import 'constants.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _searchQuery = '';
  List<String> _filteredImages = [];
  bool _isLoading = false;
  String _userName = '';
  String _errorText = '';
  final ScrollController _scrollController = ScrollController();
  bool _showRandomImages = false;
  int _randomImagesCount = 50;
  bool _showGenerateButton = true;
  List<String> _randomImages = [];
  bool _isFetchingMore = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<String>> fetchImagesFromUnsplash(String query) async {
    //final String accessKey = 'ADD_YOUR_API_KEY';
    final String url =
        'https://api.unsplash.com/search/photos?query=$query&client_id=$accessKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      List<String> imageUrls =
          data.map((e) => e['urls']['regular'] as String).toList();
      return imageUrls;
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<String>> fetchRandomTattooImages() async {
   //final String accessKey = '_OtXt-IeY0ZA8Ry4nwvslWbMeRZ8cvjFS_m6Z8yDH7A';
    final String url =
        'https://api.unsplash.com/photos/random?query=tattoo&count=$_randomImagesCount&client_id=$accessKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<String> imageUrls =
          data.map((e) => e['urls']['regular'] as String).toList();
      return imageUrls;
    } else {
      throw Exception('Failed to load images');
    }
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = '$newQuery tattoo';
      _errorText = '';
    });
  }

  Future<void> _fetchAndFilterImages() async {
    setState(() {
      _isLoading = true;
    });

    if (_searchQuery.isNotEmpty) {
      List<String> fetchedImages = await fetchImagesFromUnsplash(_searchQuery);
      setState(() {
        _filteredImages = fetchedImages;
        _isLoading = false;
      });
    } else {
      setState(() {
        _filteredImages.clear();
        _isLoading = false;
        _errorText = 'Please enter a tattoo prompt';
      });
    }
  }

  void _generateTattoos() {
    if (_searchQuery.isNotEmpty) {
      _fetchAndFilterImages();
      setState(() {
        _errorText = ''; // Clear any previous error
      });
    } else {
      setState(() {
        _errorText = 'Please enter a tattoo prompt';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a tattoo prompt'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _fetchUserName() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        _userName = userSnapshot.get('name');
        setState(() {});
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching username: $error');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
      });
      fetchRandomTattooImages().then((newImages) {
        setState(() {
          _randomImages.addAll(newImages);
          _isFetchingMore = false;
        });
      }).catchError((error) {
        setState(() {
          _isFetchingMore = false;
        });
        print('Error fetching more images: $error');
      });
    }
  }

  Future<void> _showRandomTattooImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _randomImages = await fetchRandomTattooImages();
    } catch (e) {
      setState(() {
        _errorText = 'Failed to load random images';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Find Your Tattoo',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/dragon.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.1),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Hii $_userName!!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              TextField(
                onTap: () {
                  setState(() {
                    _showRandomImages = false;
                    _showGenerateButton = true;
                  });
                  _scrollController.animateTo(
                    MediaQuery.of(context).size.height,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                onChanged: _updateSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Enter your tattoo prompt',
                  border: OutlineInputBorder(),
                  errorText: _errorText,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showRandomImages = !_showRandomImages;
                        _showGenerateButton = !_showRandomImages;
                      });

                      if (_showRandomImages) {
                        _showRandomTattooImages();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        color: _showRandomImages
                            ? Colors.black
                            : Colors.transparent,
                        child: Center(
                          child: Text(
                            'Random Tattoos',
                            style: TextStyle(
                              color: _showRandomImages
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showRandomImages = !_showRandomImages;
                        _showGenerateButton = !_showRandomImages;
                      });
                      if (!_showRandomImages) {
                        _fetchAndFilterImages();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: !_showRandomImages
                            ? Colors.black
                            : Colors.transparent,
                        child: Center(
                          child: Text(
                            'Searched Tattoo',
                            style: TextStyle(
                              color: !_showRandomImages
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Stack(
                  children: [
                    _showRandomImages
                        ? _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: _randomImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 3,
                                    child: Image.network(
                                      _randomImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )
                        : _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  height: 400.0,
                                  enlargeCenterPage: true,
                                  autoPlay: false,
                                  aspectRatio: 16 / 9,
                                  enableInfiniteScroll: true,
                                  viewportFraction: 0.8,
                                ),
                                items: _filteredImages.map((image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(
                                              15), // Add border radius here
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
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox
                            .shrink(), // Add a SizedBox.shrink() here if you don't want the CircularProgressIndicator to overlap with other widgets
                  ],
                ),
              ),
             _showGenerateButton
  ? ElevatedButton.icon(
      onPressed: _generateTattoos,
      icon: Icon(Icons.app_shortcut_rounded), // Icon for the button
      label: Text(
        'Generate Tattoos',
        style: TextStyle(fontSize: 16), // Text style for the button text
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Rounded button corners
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Button padding
      ),
    )
  : Container(),

            ],
          ),
        ),
      ),
    );
  }
}
