import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:RekaChain/unduhberkas/detailunduh_berkas.dart';

class Unduh extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_lot;

  const Unduh({Key? key, this.newProject, required this.id_lot})
      : super(key: key);

  @override
  _UnduhState createState() => _UnduhState();
}

class _UnduhState extends State<Unduh> {
  late double _screenWidth;
  late double _screenHeight;
  List<Map<String, dynamic>> _unduh = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.10.102/ProjectScanner/lib/unduhberkas/get_unduh.php?id_lot=${widget.id_lot}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _unduh = data.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        // Handle error here
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error here
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Dokumen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _unduh.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _unduh.length,
              itemBuilder: (context, index) {
                return _buildUnduhCard(_unduh[index]);
              },
            ),
    );
  }

  Widget _buildUnduhCard(Map<String, dynamic> unduhData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 23, 46, 81), // Warna biru dongker
        child: ListTile(
          title: Text(
            'Nomor Produk: ${unduhData['noProduk'] ?? 'Tidak Ada'}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'File: ${unduhData['file'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal: ${unduhData['tanggal'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          onTap: () {
            _showDetailUnduh(unduhData);
          },
        ),
      ),
    );
  }

  void _showDetailUnduh(Map<String, dynamic> detailUnduhData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailUnduh(detailunduh: detailUnduhData),
      ),
    );
  }
}
