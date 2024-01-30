import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home: NavBar(),
=======
      home: const NavBar(),
>>>>>>> 1536c39295a60b2005d6152117f56d3ea1e1af35
    );
  }
}
