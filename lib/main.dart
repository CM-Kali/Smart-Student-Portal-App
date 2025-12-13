import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/pages/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Smart Portal',
      home: const SplashPage(),
    );
  }
}
