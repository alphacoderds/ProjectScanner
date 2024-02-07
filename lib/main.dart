import 'package:RekaChain/aftersales.dart';
import 'package:RekaChain/pop_up_materiall.dart';
import 'package:RekaChain/pop_up_product.dart';
import 'package:RekaChain/pop_up_tahap_selesai.dart';
import 'package:RekaChain/profile.dart';
import 'package:RekaChain/unduh_berkas.dart';
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
      home: PopUpAfterSales(),
    );
  }
}
