import 'package:RekaChain/tahapselesai/listopenitem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TambahOpenItem extends StatefulWidget {
  final Function onSaved;
  final Map<String, String>? initialData;
  final String id_openlist;
  const TambahOpenItem({
    Key? key,
    required this.onSaved,
    this.initialData,
    required this.id_openlist,
  }) : super(key: key);

  @override
  State<TambahOpenItem> createState() => _TambahOpenItemState();
}

class _TambahOpenItemState extends State<TambahOpenItem> {
  late TextEditingController _isiController;

  @override
  void initState() {
    super.initState();
    _isiController =
        TextEditingController(text: widget.initialData?['isi'] ?? '');
  }

  Future<void> _simpan() async {
    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
            textAlign: TextAlign.left, // Tetapkan warna teks putih
          ),
          backgroundColor: const Color.fromRGBO(
              43, 56, 86, 1), // Tetapkan warna latar belakang
          content: Text(
            'Apakah Anda ingin menyimpan data?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
            ),
            textAlign: TextAlign.left, // Tetapkan warna teks putih
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.5,
                ),
                textAlign: TextAlign.center, // Tetapkan warna teks putih
              ),
            ),
            TextButton(
              onPressed: () {
                // Simpan data dan tutup dialog
                _prosesSimpan();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Ya',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.5,
                ),
                textAlign: TextAlign.center, // Tetapkan warna teks putih
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _prosesSimpan() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.10.155/ProjectScanner/lib/tahapselesai/create_openlist.php'),
      body: {
        "isi": _isiController.text,
        "id_openlist": widget.id_openlist,
      },
    );

    if (response.statusCode == 200) {
      final newProjectData = {
        "no": response.body,
        "isi": _isiController.text,
      };

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListOI(
            newProject: newProjectData,
            id_openlist: widget.id_openlist,
          ),
        ),
      );
    } else {
      print('Gagal menyimpan data: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah/Edit OpenItem'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Isi Data Open Item',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _isiController,
                decoration: InputDecoration(
                  labelText: 'Isi Open Item',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _simpan,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 21, 30, 81),
                ),
                child: Text('Simpan', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
