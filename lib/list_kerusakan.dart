import 'package:RekaChain/kerusakan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ListKerusakan extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_project;
  const ListKerusakan({Key? key, this.newProject, required this.id_project})
      : super(key: key);

  @override
  State<ListKerusakan> createState() => _ListKerusakanState();
}

class _ListKerusakanState extends State<ListKerusakan> {
  late double _screenWidth;
  late double _screenHeight;
  List<Map<String, dynamic>> _kerusakan = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.10.230/ProjectScanner/lib/API/get_kerusakan.php?id_project=${widget.id_project}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _kerusakan = data.cast<Map<String, dynamic>>();
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

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Kerusakan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _kerusakan.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _kerusakan.length,
              itemBuilder: (context, index) {
                return _buildKerusakanCard(_kerusakan[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_rounded,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 23, 46, 81), // Warna biru dongker
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahKerusakan(
                  onSaved: _addKerusakan, id_project: widget.id_project),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKerusakanCard(Map<String, dynamic> kerusakanData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 23, 46, 81), // Warna biru dongker
        child: ListTile(
          title: Text(
            'Kode Produk: ${kerusakanData['id_project'] ?? 'Tidak Ada'}',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Kerusakan: ${kerusakanData['detail_kerusakan'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Item: ${kerusakanData['item'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Keterangan: ${kerusakanData['keterangan'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal: ${kerusakanData['waktu'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          onTap: () {
            _showKerusakanDetail(kerusakanData);
          },
        ),
      ),
    );
  }

  void _showKerusakanDetail(Map<String, dynamic> kerusakanDetail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailKerusakan(kerusakanDetail: kerusakanDetail),
      ),
    );
  }

  void _addKerusakan(Map<String, dynamic> newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newData['tanggal'] = DateTime.now().toString();
    _kerusakan.insert(0, newData);
    final List<String> encodedKerusakan =
        _kerusakan.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('kerusakan', encodedKerusakan);
    setState(() {});
  }
}

class DetailKerusakan extends StatelessWidget {
  final Map<String, dynamic> kerusakanDetail;

  DetailKerusakan({required this.kerusakanDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Kerusakan')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode Produk: ${kerusakanDetail['id_project'] ?? 'Tidak Ada'}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 10),
            Text(
              'Detail Kerusakan: ${kerusakanDetail['detail_kerusakan'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 14, color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 5),
            Text(
              'Item: ${kerusakanDetail['item'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 14, color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 5),
            Text(
              'Keterangan: ${kerusakanDetail['keterangan'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 14, color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
            SizedBox(height: 10),
            Text(
              'Tanggal: ${kerusakanDetail['waktu'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 12, color: Colors.black), // Mengubah warna teks menjadi hitam
            ),
          ],
        ),
      ),
    );
  }
}
