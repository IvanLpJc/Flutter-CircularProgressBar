import 'package:animated_custom_painter/src/challenges/animated_square_page.dart';
import 'package:animated_custom_painter/src/pages/animations_page.dart';
import 'package:animated_custom_painter/src/pages/headers_page.dart';
import 'package:animated_custom_painter/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'animated_custom_painter app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
