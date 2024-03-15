import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:memes_by_sam/view/nav_drawer.dart';

class TrendingMeme {
  final String title;
  final String url;

  const TrendingMeme({required this.title, required this.url});

  factory TrendingMeme.fromJson(Map<String, dynamic> json) {
    return TrendingMeme(title: json['title'], url: json['url']);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TrendingMeme? currentMeme;

  @override
  void initState() {
    super.initState();
    fetchNewMeme();
  }

  Future<void> fetchNewMeme() async {
    final response = await http.get(
      Uri.parse('https://meme-api.com/gimme'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      TrendingMeme meme = TrendingMeme.fromJson(data);
      setState(() {
        currentMeme = meme;
      });
    } else {
      // Handle error here, you might want to show a message to the user
      print('Failed to fetch meme: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEME-STHAN', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.grey],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 550,
              child: currentMeme == null
                  ? const Center(child: CircularProgressIndicator())
                  : Card(shadowColor: Colors.black,
                color: const Color(0xFFFFF9C4),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        currentMeme!.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.network(currentMeme!.url),

                    ],

                  ),
                ),

              ),
            ),
          ],
        ),
      ),
      drawer: const NavDrawer(selected: DrawerSelection.home),
      floatingActionButton: FloatingActionButton(tooltip: 'refresh',
        backgroundColor: Colors.pinkAccent,
        shape: const CircleBorder(),
        onPressed: fetchNewMeme,
        child: const Icon(Icons.refresh),
      ),
      backgroundColor: const Color(0xFFFFF9C4), // Set the background color of the Scaffold
    );
  }
}




