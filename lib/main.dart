import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/close_item.dart';
import 'package:flutter_scanner/list_kekurangan.dart';
import 'package:flutter_scanner/open_item.dart';
import 'package:flutter_scanner/riwayat_proses.dart';
import 'package:flutter_scanner/riwayat_scan.dart';
import 'package:flutter_scanner/tambah_keterangan.dart';
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
      home: ListCloseItem(),
    );
  }
}
