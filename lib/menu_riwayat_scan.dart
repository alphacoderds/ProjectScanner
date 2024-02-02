import 'package:flutter/material.dart';
import 'package:flutter_scanner/scan_riwayat_produk.dart';
import 'package:flutter_scanner/scan_riwayat_material.dart';
import 'package:flutter_scanner/scan_riwayat_aftersales.dart';

class MenuRiwayatScan extends StatefulWidget {
  const MenuRiwayatScan({Key? key}) : super(key: key);

  @override
  State<MenuRiwayatScan> createState() => _MenuRiwayatScanState();
}

class _MenuRiwayatScanState extends State<MenuRiwayatScan> {
  final List<String> riwayatTexts = [
    'Penerimaan Product',
    'Material',
    'After Seles',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Riwayat Scan'),
            SizedBox(width: 10.0),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionalTranslation(
                  translation: Offset(0.37, 0.10),
                  child: AspectRatio(
                    aspectRatio: 11 / 8,
                    child: Image(
                      image: AssetImage('assets/images/bolder31.png'),
                      width: 170,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: riwayatTexts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanRiwayatProduk()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScanRiwayatMaterial()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScanRiwayatAfterSales()),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        '${riwayatTexts[index]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
