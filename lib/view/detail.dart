import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prakmobile/util/constants.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetail().then((value) => print(value.toString()));
  }

  Future<Map<String, dynamic>> fetchDetail() async {
    http.Response response = await http.get(
      Uri.parse(
        '$URLTmdbAPI/${Get.arguments['isMovie']}/${Get.arguments['id']}?api_key=b43e12394285a1e67bc60a13f421546a&language=en-US',
      ),
    );
    Map<String, dynamic> resultMovies = json.decode(response.body);
    return resultMovies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Image(
                  image: NetworkImage(
                    URLgetImageTmdb + snapshot.data!['backdrop_path'],
                  ),
                  colorBlendMode: BlendMode.multiply,
                  fit: BoxFit.cover,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    snapshot.data!['title'] ?? snapshot.data!['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    snapshot.data!['overview'],
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
