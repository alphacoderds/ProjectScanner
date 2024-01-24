import 'package:flutter/material.dart';
import 'package:flutter_scanner/login.dart';
import 'package:flutter_scanner/menu_utama.dart';
<<<<<<< HEAD
import 'package:flutter_scanner/riwayat_proses.dart';
=======
>>>>>>> 22370ea6fc2ce9a066b6b4e83eae8b519ce004ef

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
      home: loginpage(),
    );
  }
}
