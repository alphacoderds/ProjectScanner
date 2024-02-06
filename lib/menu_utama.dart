import 'package:flutter/material.dart';
import 'package:flutter_scanner/menu_riwayat_scan.dart';
import 'package:flutter_scanner/scan_aftersales.dart';
import 'package:flutter_scanner/scan_material.dart';
import 'package:flutter_scanner/scan_produk.dart';
import 'package:flutter_scanner/scan_tahap_selesai.dart';
import 'package:flutter_scanner/unduh_berkas.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.01,
                              left: screenWidth * 0.1,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "REKA CHAIN",
                                  style: TextStyle(
                                    fontFamily: 'Donegal One',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Selamat Datang...",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/bolder32.png',
                              width: screenWidth * 0.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildMenuItem(
                            screenWidth,
                            Icons.qr_code_scanner_rounded,
                            "Scan Material",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScannerMaterial(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          buildMenuItem(
                            screenWidth,
                            Icons.move_to_inbox_rounded,
                            "Scan Produk",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScannerProduk(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          buildMenuItem(
                            screenWidth,
                            Icons.move_to_inbox_rounded,
                            "Riwayat Scan",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MenuRiwayatScan(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildMenuItem(
                            screenWidth,
                            Icons.description_outlined,
                            "Unduh Berkas",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const unduh(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          buildMenuItem(
                            screenWidth,
                            Icons.headset_mic,
                            "After Sales",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScannerAfterSales(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: screenWidth * 0.05),
                          buildMenuItem(
                            screenWidth,
                            Icons.move_to_inbox_rounded,
                            "Tahap Selesai",
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScannerTahapSelesai(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMenuItem(
      double screenWidth, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(85, 100, 136, 1),
              borderRadius: BorderRadius.circular(screenWidth * 0.1),
            ),
            child: Icon(
              icon,
              color: Color.fromRGBO(43, 56, 86, 1),
              size: screenWidth * 0.2,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
