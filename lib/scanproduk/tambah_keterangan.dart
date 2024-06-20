import 'dart:convert';

import 'package:RekaChain/scanproduk/keterangan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TambahKeterangan extends StatefulWidget {
  final String id_lot;
  const TambahKeterangan({Key? key, required this.id_lot}) : super(key: key);

  @override
  State<TambahKeterangan> createState() => _TambahKeteranganState();
}

class _TambahKeteranganState extends State<TambahKeterangan> {
  TextEditingController keteranganController = TextEditingController();
  String nip = '';

  Future<void> fetchNIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nip = prefs.getString('nip') ?? '';
    });
  }

  void _updateDataAndNavigateToListProject() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.10.102/ProjectScanner/lib/scanproduk/update_keterangan.php'),
        body: {
          'id_lot': widget.id_lot,
          'Keterangan_produk': keteranganController.text,
          'nip': nip,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Keterangan(
              step: data['step'],
              id_lot: widget.id_lot,
            ),
          ),
        );
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print(int.parse(widget.id_lot).runtimeType);
      print(nip.runtimeType);
      print('Error updating data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    keteranganController = TextEditingController();
    fetchNIP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Tambah Keterangan'),
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  controller: keteranganController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Isi Keterangan',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  minLines: 4,
                  maxLines: null,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: IconButton(
            onPressed: () {
              _updateDataAndNavigateToListProject();
            },
            icon: Icon(
              Icons.check_box_outlined,
              size: 40,
            ),
          ),
        ),
      ]),
    );
  }
}
