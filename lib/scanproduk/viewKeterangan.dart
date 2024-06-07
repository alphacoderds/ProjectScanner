import 'dart:convert';
import 'package:RekaChain/scanproduk/keterangan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ViewKeterangan extends StatefulWidget {
  final String id_lot;
  final Map<String, dynamic> selectedProject;
  const ViewKeterangan(
      {super.key, required this.id_lot, this.selectedProject = const {}});

  @override
  State<ViewKeterangan> createState() => _ViewKeteranganState();
}

class _ViewKeteranganState extends State<ViewKeterangan> {
  TextEditingController keteranganController = TextEditingController();

  void fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.10.155/ProjectScanner/lib/API/update_keterangan.php?no=${widget.selectedProject['id_lot']}'),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final keterangan = responseData['keterangan_produk'];
        setState(() {
          keteranganController.text = keterangan;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _updateDataAndNavigateToListProject() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.10.155/ProjectScanner/lib/API/update_keterangan.php'),
        body: {
          'id_lot': widget.selectedProject['id_lot'],
          'keterangan_produk': keteranganController.text,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Keterangan(
              id_lot: widget.id_lot,
            ),
          ),
        );
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    keteranganController = TextEditingController(
        text: widget.selectedProject['keterangan_produk'] ?? '');

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keterangan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/bolder32.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: TextField(
                controller: keteranganController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                minLines: 4, // Mengatur jumlah baris minimum
                maxLines: null,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  _updateDataAndNavigateToListProject();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Keterangan(
                              id_lot: widget.id_lot,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const SizedBox(
                    width: 70,
                    height: 40,
                    child: Center(
                      child: Text(
                        "Simpan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
