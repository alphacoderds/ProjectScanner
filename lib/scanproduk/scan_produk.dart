import 'dart:convert';
import 'package:RekaChain/provider/user_provider.dart';
import 'package:RekaChain/scanproduk/pop_up_product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScannerProduk extends StatefulWidget {
  const ScannerProduk({super.key});

  @override
  _ScannerProdukState createState() => _ScannerProdukState();
}

class _ScannerProdukState extends State<ScannerProduk> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final int nip = userProvider.dataModel.nip;

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
              builder: (context) => PopUpProduk(
                  id_lot: barcodeScanRes,
                  nip: nip.toString(),
                  onConfirm: (int currentStep) =>
                      _updateStatus(barcodeScanRes, nip.toString()))),
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _updateStatus(String id_lot, String nip) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.8.26/ProjectScanner/lib/scanproduk/update_status.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id_lot': id_lot,
        'nip': nip,
      },
    );

    final responseData = json.decode(response.body);
    debugPrint("Response: ${response.body}");

    if (responseData['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${responseData['message']} Tahap: ${responseData['current_step']}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message']),
          duration: const Duration(seconds: 3),
        ),
      );
    }
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
                    color: Color.fromRGBO(149, 0, 0, 1),
                    size: 180,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Scan Produk',
                    style: TextStyle(
                        color: Color.fromARGB(255, 85, 19, 19), fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//cek null kolom status