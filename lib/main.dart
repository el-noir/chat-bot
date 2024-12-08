import 'package:flutter/material.dart';
import 'pages/custompage.dart';
import 'pages/page1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page with Routes',
      // Define routes
      routes: {
        '/': (context) => Custompage(), // Main Page
        '/page1': (context) => Page1(), // Page 1
      },
    );
  }
}
