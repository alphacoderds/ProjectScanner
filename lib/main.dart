<<<<<<< HEAD
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/menu_riwayat_scan.dart';
import 'package:RekaChain/riwayat_proses.dart';
import 'package:RekaChain/riwayat_scan.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/aftersales.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/login.dart';
=======
import 'package:RekaChain/open_item.dart';
>>>>>>> 9b259fcae73775d3cc07dba045a5e118ef660e1d
import 'package:RekaChain/pop_up_materiall.dart';
import 'package:flutter/material.dart';

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
      home: PopUpMaterial(),
    );
  }
}
