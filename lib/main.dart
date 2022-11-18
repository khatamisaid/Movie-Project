import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prakmobile/view/movie_list.dart';
import 'package:prakmobile/view/tv_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const MovieList(),
        ),
        GetPage(
          name: '/tvList',
          page: () => const TvList(),
        ),
      ],
      initialRoute: '/',
      home: const MovieList(),
    );
  }
}
