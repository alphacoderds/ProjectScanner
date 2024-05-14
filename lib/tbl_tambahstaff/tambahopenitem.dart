import 'dart:convert';

import 'package:RekaChain/model/data_model.dart';
import 'package:RekaChain/open_item.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/updateprofile.dart';
import 'package:RekaChain/login.dart';
import 'package:http/http.dart' as http;

class TambahOpenItem extends StatefulWidget {
  final String nip;
  const TambahOpenItem({super.key, required this.nip});

  @override
  State<TambahOpenItem> createState() => _TambahOpenItemState();
}

class _TambahOpenItemState extends State<TambahOpenItem> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? _userData;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  TextEditingController keteranganController = TextEditingController();

  bool _isLoading = true;
  String _errorMessage = 'Terjadi kesalahan saat mengambil data';

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.9.177/ProjectScanner/lib/API/create_openlist.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Filter data berdasarkan NIP yang telah diperoleh sebelumnya
        Map<String, dynamic>? userData;
        for (var userDataItem in data) {
          if (userDataItem['nip'] == widget.nip) {
            userData = userDataItem;
            break;
          }
        }

        if (userData != null) {
          // Setel state untuk menampilkan data pengguna yang sesuai
          setState(() {
            _userData = userData;
            _isLoading = false;
          });
        } else {
          // Tampilkan pesan jika data pengguna tidak ditemukan
          setState(() {
            _isLoading = false;
            _errorMessage = 'Data pengguna tidak ditemukan';
          });
        }
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi
      print(e);
      setState(() {
        _isLoading = false;
        _errorMessage = 'Terjadi kesalahan saat mengambil data';
      });
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _simpan() async {
    if (!formKey.currentState!.validate()) return;

    // Create the new data entry
    final newData = {
      'keterangan': keteranganController.text,
    };

    // Return the new data to the calling screen
    Navigator.pop(context, newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Keterangan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListOpenItem()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Placeholder untuk menampilkan data pengguna
            // Anda dapat menambahkan ini kembali setelah menyelesaikan penambahan data

            SizedBox(height: 8.0),
            // Ganti dengan widget untuk menampilkan data user

            SizedBox(height: 16.0),
            // Form untuk menambahkan data baru
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: keteranganController,
                    decoration: InputDecoration(labelText: 'Keterangan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Keterangan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _simpan(); // Panggil method _simpan() saat tombol "Simpan" ditekan
                      }
                    },
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextView(String label, {required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 16.0,
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Logika logout
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
