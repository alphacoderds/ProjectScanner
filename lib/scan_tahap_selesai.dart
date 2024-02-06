import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scanner/pop_up_tahap_selesai.dart';

class ScannerTahapSelesai extends StatefulWidget {
  const ScannerTahapSelesai({super.key});

  @override
  _ScannerTahapSelesaiState createState() => _ScannerTahapSelesaiState();
}

class _ScannerTahapSelesaiState extends State<ScannerTahapSelesai> {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hasil scan: $barcodeScanRes'),
          duration: const Duration(seconds: 3),
        ),
      );

      if (barcodeScanRes != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PopUpTahapSelesai()),
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
                padding: const EdgeInsets.all(25),
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
                    size: 220,
                  ),
                  SizedBox(height: 20),
                  Text('Scan Tahap Selesai'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
