import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ListProduk extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_lot;
  const ListProduk({Key? key, this.newProject, required this.id_lot})
      : super(key: key);

  @override
  State<ListProduk> createState() => _ListRiwayatProdukState();
}

class _ListRiwayatProdukState extends State<ListProduk> {
  late double _screenWidth;
  late double _screenHeight;
  List<Map<String, dynamic>> _RiwayatProduk = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.9.138/ProjectScanner/lib/riwayatscan/get_afproduk.php?id_lot=${widget.id_lot}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> groupedData = _groupAndSortData(data);
        setState(() {
          _RiwayatProduk = groupedData;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
        // Tambahkan penanganan kesalahan di sini
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Tambahkan penanganan kesalahan di sini
    }
  }

  List<Map<String, dynamic>> _groupAndSortData(List<dynamic> data) {
    List<Map<String, dynamic>> groupedData = [];

    for (var item in data) {
      for (int i = 1; i <= 10; i++) {
        String apKey = 'ap$i';
        String kategoriKey = 'kategori$i';
        String tanggalMulaiKey = 'tanggal_mulai$i';
        String tanggalSelesaiKey = 'tanggal_selesai$i';
        String statusKey = 'status$i';
        String nipKey = 'nip$i';
        String namaKey = 'nama$i';
        String keteranganKey = 'keterangan$i';
        String keteranganProdukKey = 'keterangan_produk$i';

        if (item.containsKey(apKey) &&
            item[apKey] != null &&
            item[apKey] != '') {
          groupedData.add({
            'ap': item[apKey],
            'kategori': item[kategoriKey],
            'tanggal_mulai': item[tanggalMulaiKey],
            'tanggal_selesai': item[tanggalSelesaiKey],
            'status': item[statusKey],
            'nip': item[nipKey],
            'nama': item[namaKey],
            'keterangan': item[keteranganKey],
            'keterangan_produk': item[keteranganProdukKey],
          });
        }
      }
    }

    return groupedData;
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Produk'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _RiwayatProduk.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _RiwayatProduk.length,
              itemBuilder: (context, index) {
                return _buildRiwayatProdukCard(_RiwayatProduk[index]);
              },
            ),
    );
  }

  Widget _buildRiwayatProdukCard(Map<String, dynamic> RiwayatProdukData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 23, 46, 81), // Warna biru dongker
        child: ListTile(
          title: Text(
            'Alur Proses: ${RiwayatProdukData['ap'] ?? 'Tidak Ada'}',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kategori: ${RiwayatProdukData['kategori'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Keterangan: ${RiwayatProdukData['keterangan'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Status: ${RiwayatProdukData['status'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Keterangan Produk: ${RiwayatProdukData['keterangan_produk'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'NIP: ${RiwayatProdukData['nip'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Nama: ${RiwayatProdukData['nama'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Tanggal Mulai: ${RiwayatProdukData['tanggal_mulai'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Tanggal Selesai: ${RiwayatProdukData['tanggal_selesai'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _addRiwayatProduk(Map<String, dynamic> newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newData['tanggal'] = DateTime.now().toString();
    _RiwayatProduk.insert(0, newData);
    final List<String> encodedRiwayatProduk =
        _RiwayatProduk.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('RiwayatProduk', encodedRiwayatProduk);
    setState(() {});
  }
}
