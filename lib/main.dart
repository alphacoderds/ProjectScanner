import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/menu_riwayat_scan.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/pop_up_materiall.dart';
import 'package:flutter_scanner/pop_up_product.dart';
import 'package:flutter_scanner/pop_up_tahap_selesai.dart';
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
      home: PopUpTahapSelesai(),
    );
  }
}
