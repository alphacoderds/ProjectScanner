import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/list_kerusakan.dart';
import 'package:RekaChain/menu_riwayat_scan.dart';
import 'package:RekaChain/riwayat_proses.dart';
import 'package:RekaChain/riwayat_scan.dart';
import 'package:RekaChain/tabel_scan_material.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/aftersales.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/open_item.dart';
import 'package:RekaChain/pop_up_materiall.dart';
import 'package:RekaChain/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
      home: TabelScanMaterial(),
    );
  }
}
