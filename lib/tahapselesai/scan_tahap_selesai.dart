import 'dart:convert';
import 'package:RekaChain/provider/user_provider.dart';
import 'package:RekaChain/tahapselesai/pop_up_tahap_selesai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScannerTahapSelesai extends StatefulWidget {
  const ScannerTahapSelesai({Key? key}) : super(key: key);

  @override
  _ScannerTahapSelesaiState createState() => _ScannerTahapSelesaiState();
}

class _ScannerTahapSelesaiState extends State<ScannerTahapSelesai> {
  late double screenWidth;
  late double screenHeight;

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
            builder: (context) => PopUpTahapSelesai(
              id_lot: barcodeScanRes,
              nip: nip.toString(),
              id_openlist: barcodeScanRes,
              onConfirm: (int currentStep) =>
                  _updateStatus(barcodeScanRes, nip.toString()),
            ),
          ),
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
          'http://192.168.9.138/ProjectScanner/lib/tahapselesai/update_tahapselesai.php'),
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
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reka Chain'),
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
                  Text('Scan Tahap Selesai',
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
