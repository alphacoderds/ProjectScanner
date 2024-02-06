import 'package:flutter/material.dart';
import 'package:flutter_scanner/aftersales.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/login.dart';
import 'package:flutter_scanner/menu_riwayat_scan.dart';
import 'package:flutter_scanner/menu_utama.dart';
import 'package:flutter_scanner/pop_up_materiall.dart';
import 'package:flutter_scanner/pop_up_product.dart';
import 'package:flutter_scanner/profile.dart';
import 'package:flutter_scanner/riwayat_scan.dart';
import 'package:flutter_scanner/updateprofile.dart';
import 'package:flutter_scanner/pop_up_tahap_selesai.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: NavBar(),
          );
        });
  }
}
