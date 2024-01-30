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
<<<<<<< HEAD
    return const MaterialApp(
      home: scan(),
=======
    return MaterialApp(
      home: Scanner(),
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831
    );
  }
}

<<<<<<< HEAD
class scan extends StatelessWidget {
  const scan({super.key});
=======
class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
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
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() {});
  }
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
=======
        title: Row(
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831
          children: [
            Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 10, 10, 10),
            ),
            SizedBox(width: 8),
            Text('Reka Chain'),
          ],
        ),
      ),
      body: Align(
<<<<<<< HEAD
        alignment: const Alignment(0, -0.5), // Mengatur posisi tombol ke atas
=======
        alignment: Alignment(0, -0.5),
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                scanBarcodeNormal(); // Panggil fungsi untuk melakukan pemindaian barcode
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
<<<<<<< HEAD
            const SizedBox(
                height: 20), // Jarak antara tombol "Scan" dan tombol "Process"
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol "Process" ditekan
                print('Processing...');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16), backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), // Warna putih untuk tombol "Process"
              ),
              child: const Text('Process'),
            ),
            const SizedBox(
                height:
                    20), // Jarak antara tombol "Process" dan pemenuhan kekurangan
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol pemenuhan kekurangan ditekan
                print('Pemenuhan Kekurangan...');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Pemenuhan Kekurangan'),
            ),
=======
>>>>>>> 0081def1a3311b5922f7f8382ba5d33619156831
          ],
        ),
      ),
    );
  }
}
