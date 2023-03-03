import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storebase/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        shadowColor: Color(0xFF1D76BE),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Store Base',
      home: HomeScreen(),
    );
  }
}
