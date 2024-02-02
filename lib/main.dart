import 'package:flutter/material.dart';
import 'package:flutter_scanner/aftersales.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/menu_riwayat_scan.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/pop_up_materiall.dart';
import 'package:flutter_scanner/pop_up_product.dart';
<<<<<<< HEAD
import 'package:flutter_scanner/profile.dart';
=======
import 'package:flutter_scanner/pop_up_tahap_selesai.dart';
>>>>>>> 2e3ba8ad5bd402f8aa7c86889c5739c2e61ef16a
import 'package:flutter_scanner/riwayat_scan.dart';
import 'package:flutter_scanner/updateprofile.dart';

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
      home: ProfilePage(),
=======
      home: PopUpTahapSelesai(),
>>>>>>> 2e3ba8ad5bd402f8aa7c86889c5739c2e61ef16a
    );
  }
}
