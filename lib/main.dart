import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_scanner/aftersales.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/keterangan.dart';
import 'package:flutter_scanner/login.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/profile.dart';
import 'package:flutter_scanner/pop_up_product.dart';
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831
import 'package:flutter_scanner/riwayat_proses.dart';
import 'package:flutter_scanner/riwayat_scan.dart';

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
      home: const RiwayatScan(),
=======
      home: Scanner(),
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831
    );
  }
}


