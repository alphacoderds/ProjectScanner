import 'package:RekaChain/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/login.dart';
import 'package:flutter_scanner/aftersales.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/login.dart';
import 'package:flutter_scanner/pop_up_materiall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RekaChain',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavBar(),
    );
  }
}
