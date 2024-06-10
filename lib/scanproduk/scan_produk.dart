import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:RekaChain/model/data_model.dart';
import 'package:RekaChain/provider/user_provider.dart';
import 'package:RekaChain/scanproduk/pop_up_product.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerProduk extends StatefulWidget {
  const ScannerProduk({Key? key}) : super(key: key);

  @override
  _ScannerProdukState createState() => _ScannerProdukState();
}

class _ScannerProdukState extends State<ScannerProduk> {
  late double screenWidth;
  late double screenHeight;
  late UserProvider provider;

  @override
  void initState() {
    super.initState();
    // Panggil _loadNip() dalam initState
    _loadNip();
  }

  Future<void> _loadNip() async {
    // Inisialisasi provider
    provider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      provider.dataModel.nip = prefs.getString('nip') ?? '';
    });
  }

  Future<void> scanBarcodeNormal(DataModel dataModel) async {
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
            builder: (context) => PopUpProduk(
              id_lot: barcodeScanRes,
              nip: dataModel.nip,
              onConfirm: (int currentStep) => _updateStatus(
                barcodeScanRes,
                currentStep,
                dataModel.nip,
              ),
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

  Future<void> _updateStatus(String id_lot, int currentStep, String nip) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.8.207/ProjectScanner/lib/scanproduk/update_status.php'),
      body: {
        'id_lot': id_lot,
        'nip': nip,
        'current_step': currentStep.toString(),
      },
    );

    final responseData = json.decode(response.body);

    if (responseData['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseData['message']),
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
    // Dapatkan screenWidth dan screenHeight pada saat membangun widget
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
            Consumer<UserProvider>(builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: () {
                  if (provider.dataModel.nip.isNotEmpty) {
                    // Cek apakah NIP sudah dimuat sebelum memulai pemindaian barcode
                    scanBarcodeNormal(provider.dataModel);
                  } else {
                    // Tampilkan pesan jika NIP belum dimuat
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('NIP belum dimuat'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
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
                        color: Color.fromARGB(255, 85, 19, 19),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
