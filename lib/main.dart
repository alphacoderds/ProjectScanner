import 'package:RekaChain/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/aftersales.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/pop_up_materiall.dart';

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
