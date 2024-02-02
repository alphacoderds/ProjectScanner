import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
<<<<<<< HEAD
import 'package:flutter_scanner/list_kekurangan.dart';
import 'package:flutter_scanner/open_item.dart';
import 'package:flutter_scanner/riwayat_proses.dart';
import 'package:flutter_scanner/riwayat_scan.dart';
import 'package:flutter_scanner/tambah_keterangan.dart';
=======
import 'package:flutter_scanner/menu_riwayat_scan.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/pop_up_materiall.dart';
>>>>>>> f36b647055212404240eda69ed8141d1d3adeb10
import 'package:flutter_scanner/pop_up_product.dart';
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
      home: ListOpenItem(),
=======
      home: MenuRiwayatScan(),
>>>>>>> f36b647055212404240eda69ed8141d1d3adeb10
    );
  }
}
