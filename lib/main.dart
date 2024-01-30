import 'package:flutter/material.dart';
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
      home: const RiwayatScan(),
    );
  }
}


