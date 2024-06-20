import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/aftersales/list_kerusakan.dart';
import 'package:RekaChain/riwayatscan/menu_riwayat_scan.dart';
import 'package:RekaChain/profile/profile.dart';
import 'package:RekaChain/provider/user_provider.dart';

import 'package:RekaChain/scanmaterial/tabel_scan_material.dart';
import 'package:RekaChain/profile/updateprofile.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/login.dart';
import 'package:RekaChain/aftersales/aftersales.dart';
import 'package:RekaChain/bottomnavbar.dart';

import 'package:RekaChain/tahapselesai/listopenitem.dart';
import 'package:RekaChain/scanmaterial/pop_up_materiall.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
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
      home: LoginPage(),
    );
  }
}
