import 'package:RekaChain/riwayatscan/list_riwayatproduct.dart';
import 'package:RekaChain/riwayatscan/view_RMaterial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:RekaChain/riwayatscan/list_aftersales.dart';

class ScanRiwayatMaterial extends StatefulWidget {
  const ScanRiwayatMaterial({super.key});

  @override
  _ScanRiwayatMaterialState createState() => _ScanRiwayatMaterialState();
}

class _ScanRiwayatMaterialState extends State<ScanRiwayatMaterial> {
  late double screenWidth;
  late double screenHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hasil scan: $barcodeScanRes'),
          duration: const Duration(seconds: 3),
        ),
      );

      if (barcodeScanRes != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewRiwayatMaterial(kodeLot: barcodeScanRes)),
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text('Reka Chain'),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: screenHeight * 0.2),
            ElevatedButton(
              onPressed: () {
                scanBarcodeNormal();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Color.fromARGB(255, 251, 249, 249),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.center_focus_weak,
                    color: Color.fromRGBO(149, 0, 0, 1),
                    size: 180,
                  ),
                  SizedBox(height: 20),
                  Text('Scan Riwayat Material',
                      style: TextStyle(
                          color: Color.fromARGB(255, 85, 19, 19),
                          fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
