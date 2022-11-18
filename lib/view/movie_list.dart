import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prakmobile/component/card_view.dart';
import 'package:prakmobile/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:prakmobile/util/constants.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
    fetchMovie().then((value) => print(value.length));
  }

  Future<List<dynamic>> fetchMovie() async {
    http.Response response = await http.get(Uri.parse(
        '$URLTmdbAPI/movie/now_playing?api_key=b43e12394285a1e67bc60a13f421546a&language=en-US&page=1'));
    Map<String, dynamic> resultMovies = json.decode(response.body);
    return resultMovies['results'];
  }

  Widget movieList() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: movieList(),
          ),
        ),
      ),
    );
  }
}
