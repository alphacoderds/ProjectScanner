import 'package:flutter/material.dart';
import 'package:RekaChain/menu_riwayat_scan.dart';
import 'package:RekaChain/scan_aftersales.dart';
import 'package:RekaChain/scan_material.dart';
import 'package:RekaChain/scan_produk.dart';
import 'package:RekaChain/scan_tahap_selesai.dart';
import 'package:RekaChain/unduh_berkas.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.035),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.001,
                              left: screenWidth * 0.09,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "REKA CHAIN",
                                  style: TextStyle(
                                    fontFamily: 'Donegal One',
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Selamat Datang...",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.075,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(), // Spacer untuk memberikan ruang di antara dua kolom
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.0001),
                              child: Image.asset(
                                'assets/images/bolder32.png',
                                width: screenWidth * 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.13),
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
                          SizedBox(width: screenWidth * 0.06),
                          buildMenuItem(
                            screenWidth,
                            Icons.qr_code_scanner_rounded,
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
                          SizedBox(width: screenWidth * 0.06),
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
                      SizedBox(height: screenHeight * 0.06),
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
                          SizedBox(width: screenWidth * 0.06),
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
                          SizedBox(width: screenWidth * 0.06),
                          buildMenuItem(
                            screenWidth,
                            Icons.fact_check_outlined,
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
            padding: EdgeInsets.all(screenWidth * 0.029),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(85, 100, 136, 1),
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
            ),
            child: Icon(
              icon,
              color: Color.fromRGBO(43, 56, 86, 1),
              size: screenWidth * 0.19,
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
