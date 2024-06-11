import 'dart:convert';
import 'package:RekaChain/aftersales/saran_tindak_lanjut.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Import your list_saran file to navigate back to it

class TambahSaran extends StatefulWidget {
  final String id_project;
  const TambahSaran({super.key, required this.id_project});

  @override
  State<TambahSaran> createState() => _TambahSaranState();
}

class _TambahSaranState extends State<TambahSaran> {
  TextEditingController saranController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final currentTime = DateTime.now().toIso8601String();
        final response = await http.post(
          Uri.parse(
              'http://192.168.8.207/ProjectScanner/lib/aftersales/update_saran.php'),
          body: {
            'id_lot': widget.id_project,
            'saran': saranController.text,
            'waktu_saran': currentTime,
          },
        );

        final responseData = jsonDecode(response.body);
        if (response.statusCode == 200 && responseData['pesan'] == 'Sukses') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ListSaran(
                      id_project: widget.id_project,
                    )),
            (Route<dynamic> route) => false,
          );
        } else {
          print('Failed to submit data: ${responseData['pesan']}');
        }
      } catch (e) {
        print('Error submitting data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Data Konsumen'),
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
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              SizedBox(
                width: 350,
                child: TextFormField(
                  controller: saranController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Isi Data Kekurangan',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  minLines: 4,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data Kekurangan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const SizedBox(
                  width: 70,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Simpan",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Saran extends StatelessWidget {
  final String saran;
  final String id_project;
  final String waktu_saran;

  const Saran(
      {super.key,
      required this.saran,
      required this.waktu_saran,
      required this.id_project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saran: $saran'),
            SizedBox(height: 10),
            Text('Waktu_saran: $waktu_saran'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListSaran(
                      id_project: id_project,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const SizedBox(
                width: 150,
                height: 40,
                child: Center(
                  child: Text(
                    "Kembali ke Daftar",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
