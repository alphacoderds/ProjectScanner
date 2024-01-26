import 'package:flutter/material.dart';
import 'package:flutter_scanner/login.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/pop_up_product.dart';
import 'package:flutter_scanner/riwayat_proses.dart';
import 'package:flutter_scanner/scan.dart';
import 'package:flutter_scanner/updateprofile.dart';

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
