import 'package:RekaChain/aftersales/kerusakan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ListAF extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_project;
  const ListAF({Key? key, this.newProject, required this.id_project})
      : super(key: key);

  @override
  State<ListAF> createState() => _ListAFState();
}

class _ListAFState extends State<ListAF> {
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
          'http://192.168.10.102/ProjectScanner/lib/riwayatscan/get_afsaran.php?id_project=${widget.id_project}'));
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
        title: Text('List After Sales'),
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
    );
  }

  Widget _buildKerusakanCard(Map<String, dynamic> kerusakanData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 23, 46, 81), // Warna biru dongker
        child: ListTile(
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Kerusakan: ${kerusakanData['detail_kerusakan'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                'Tanggal: ${kerusakanData['waktu'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 18, color: Colors.white),
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
      appBar: AppBar(title: Text('Detail AfterSales')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Detail Kerusakan : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    TextSpan(
                      text:
                          '${kerusakanDetail['detail_kerusakan'] ?? 'Tidak Ada'}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Item : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    TextSpan(
                      text: '${kerusakanDetail['item'] ?? 'Tidak Ada'}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Keterangan : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    TextSpan(
                      text: '${kerusakanDetail['keterangan'] ?? 'Tidak Ada'}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tanggal : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    TextSpan(
                      text: '${kerusakanDetail['waktu'] ?? 'Tidak Ada'}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Saran : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    TextSpan(
                      text: '${kerusakanDetail['saran'] ?? 'Tidak Ada'}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 19),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
