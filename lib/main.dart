import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prakmobile/view/detail.dart';
import 'package:prakmobile/view/home.dart';

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
          page: () => const Home(),
        ),
        GetPage(
          name: '/detail',
          page: () => const Detail(),
        ),
      ],
      initialRoute: '/',
      home: const Home(),
    );
  }
}
