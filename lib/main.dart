import 'package:flutter/material.dart';
import 'package:playdot/screens/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
     // home: GridTilePage(),

     theme:ThemeData(
    textTheme:  const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      
    ).apply(
      bodyColor: Colors.white, 
      displayColor: Colors.white, 
      
    ),
  ),
     
    );
  }
}