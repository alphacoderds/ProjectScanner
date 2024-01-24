import 'package:flutter/material.dart';
import 'package:flutter_scanner/login.dart';
import 'package:flutter_scanner/menu_utama.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuUtama(),
    );
  }
}
