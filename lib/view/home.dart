import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prakmobile/component/card_view.dart';
import 'package:http/http.dart' as http;
import 'package:prakmobile/util/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    menus = [
      buildMovieList(),
      buildMoviePopular(),
      buildTvOnAir(),
      buildTvPopular(),
    ];
  }

  Future<List<dynamic>> fetchMovie() async {
    http.Response response = await http.get(Uri.parse(
        '$URLTmdbAPI/movie/now_playing?api_key=b43e12394285a1e67bc60a13f421546a&language=en-US&page=1'));
    Map<String, dynamic> resultMovies = json.decode(response.body);
    return resultMovies['results'];
  }

  Future<List<dynamic>> fetchMoviePopular() async {
    http.Response response = await http.get(Uri.parse(
        '$URLTmdbAPI/movie/popular?api_key=b43e12394285a1e67bc60a13f421546a&language=en-US&page=1'));
    Map<String, dynamic> resultMovies = json.decode(response.body);
    return resultMovies['results'];
  }

  Future<List<dynamic>> fetchTvOnAir() async {
    http.Response response = await http.get(Uri.parse(
        '$URLTmdbAPI/tv/airing_today?api_key=b43e12394285a1e67bc60a13f421546a&language=en-US&page=1'));
    Map<String, dynamic> resultMovies = json.decode(response.body);
    return resultMovies['results'];
  }

  Future<List<dynamic>> fetchTvPopular() async {
    http.Response response = await http.get(Uri.parse(
        '$URLTmdbAPI/tv/popular?api_key=b43e12394285a1e67bc60a13f421546a&language=en-US&page=1'));
    Map<String, dynamic> resultMovies = json.decode(response.body);
    return resultMovies['results'];
  }

  Widget buildMoviePopular() {
    return FutureBuilder<List<dynamic>>(
      future: fetchMoviePopular(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('');
        }
        return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: snapshot.data!.map((e) => CardView(data: e)).toList());
      },
    );
  }

  Widget buildMovieList() {
    return FutureBuilder<List<dynamic>>(
      future: fetchMovie(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('');
        }
        return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: snapshot.data!.map((e) => CardView(data: e)).toList());
      },
    );
  }

  Widget buildTvOnAir() {
    return FutureBuilder<List<dynamic>>(
      future: fetchTvOnAir(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('');
        }
        return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: snapshot.data!.map((e) => CardView(data: e)).toList());
      },
    );
  }

  Widget buildTvPopular() {
    return FutureBuilder<List<dynamic>>(
      future: fetchTvPopular(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('');
        }
        return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: snapshot.data!.map((e) => CardView(data: e)).toList());
      },
    );
  }

  List<Widget> menus = [];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Project'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: menus[currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.movie,
              ),
              label: 'Movie List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter), label: 'Movie Popular'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Tv Show'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Tv Popular'),
        ],
      ),
    );
  }
}
