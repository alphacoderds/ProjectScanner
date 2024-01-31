import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScannerProduk(),
    );
  }
}

class ScannerProduk extends StatefulWidget {
  const ScannerProduk({super.key});

  @override
  _ScannerProdukState createState() => _ScannerProdukState();
}

class _ScannerProdukState extends State<ScannerProduk> {
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'cancel',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);

      // Tampilkan pesan setelah selesai melakukan scan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hasil scan: $barcodeScanRes'),
          duration: const Duration(seconds: 3),
        ),
      );
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
        alignment: const Alignment(0, -0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                scanBarcodeNormal();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
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
                    size: 180,
                  ),
                  SizedBox(height: 20),
                  Text('Scan'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
