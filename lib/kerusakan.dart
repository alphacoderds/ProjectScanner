import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Untuk mengformat tanggal dan waktu
import 'package:RekaChain/list_kerusakan.dart'; // Impor file ListKerusakan untuk navigasi ke halaman tersebut

class TambahKerusakan extends StatefulWidget {
  final Function onSaved;
  final Map<String, String>? initialData;
  final String id_project;
  const TambahKerusakan({
    Key? key,
    required this.onSaved,
    this.initialData,
    required this.id_project,
  }) : super(key: key);

  @override
  State<TambahKerusakan> createState() => _TambahKerusakanState();
}

class _TambahKerusakanState extends State<TambahKerusakan> {
  TextEditingController _detailKerusakanController = TextEditingController();
  TextEditingController _itemController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  TextEditingController _waktuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _detailKerusakanController = TextEditingController(
        text: widget.initialData?['detail_kerusakan'] ?? '');
    _itemController =
        TextEditingController(text: widget.initialData?['item'] ?? '');
    _keteranganController =
        TextEditingController(text: widget.initialData?['keterangan'] ?? '');
    _waktuController = TextEditingController(
        text: widget.initialData?['waktu'] ?? ''); // Inisialisasi waktu
  }

  Future<void> _simpan() async {
    // Format waktu ke format yang sesuai dengan server PHP
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final response = await http.post(
      Uri.parse(
          'http://192.168.9.60/ProjectScanner/lib/API/save_kerusakan.php'),
      body: {
        "id_project": widget.id_project,
        "item": _itemController.text,
        "detail_kerusakan": _detailKerusakanController.text,
        "keterangan": _keteranganController.text,
        "waktu": formattedDateTime, // Menggunakan waktu yang diformat
      },
    );

    if (response.statusCode == 200) {
      final newProjectData = {
        "id": response.body,
        "detail_kerusakan": _detailKerusakanController.text,
        "item": _itemController.text,
        "keterangan": _keteranganController.text,
        "waktu": formattedDateTime, // Menggunakan waktu yang diformat
      };

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListKerusakan(
            newProject: newProjectData,
            id_project: widget.id_project,
          ),
        ),
      );
    } else {
      print('Gagal menyimpan data: ${response.statusCode}');
    }
    print('Mohon lengkapi nama project.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah/Edit Kerusakan'),
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
                'Isi Data Kerusakan',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _detailKerusakanController,
                decoration: InputDecoration(
                  labelText: 'Detail Kerusakan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _simpan,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
