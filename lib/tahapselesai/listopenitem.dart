import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:RekaChain/tahapselesai/tambahopenitem.dart';

class ListOI extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_openlist;
  const ListOI({Key? key, this.newProject, required this.id_openlist})
      : super(key: key);

  @override
  State<ListOI> createState() => _ListOIState();
}

class _ListOIState extends State<ListOI> {
  late double _screenWidth;
  late double _screenHeight;
  List<Map<String, dynamic>> _OpenItem = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.11.164/ProjectScanner/lib/tahapselesai/read_openlist.php?id_openlist=${widget.id_openlist}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _OpenItem = data.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('List Open Item'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _OpenItem.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _OpenItem.length,
              itemBuilder: (context, index) {
                return _buildOpenItemCard(_OpenItem[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_rounded,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 23, 46, 81),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahOpenItem(
                  onSaved: _addOpenItem, id_openlist: widget.id_openlist),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOpenItemCard(Map<String, dynamic> OpenItemData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 23, 46, 81),
        child: ListTile(
          title: Text(
            'Kode Produk: ${OpenItemData['id_openlist'] ?? 'Tidak Ada'}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Open Item: ${OpenItemData['isi'] ?? 'Tidak Ada'}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          onTap: () {
            _showOpenItemDetail(OpenItemData);
          },
        ),
      ),
    );
  }

  void _showOpenItemDetail(Map<String, dynamic> OpenItemDetail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailOpenItem(OpenItemDetail: OpenItemDetail),
      ),
    );
  }

  void _addOpenItem(Map<String, dynamic> newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newData['tanggal'] = DateTime.now().toString();
    setState(() {
      _OpenItem.insert(0, newData);
    });
    final List<String> encodedOpenItem =
        _OpenItem.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('OpenItem', encodedOpenItem);
  }
}

class DetailOpenItem extends StatelessWidget {
  final Map<String, dynamic> OpenItemDetail;

  DetailOpenItem({required this.OpenItemDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail OpenItem')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode Produk: ${OpenItemDetail['id_openlist'] ?? 'Tidak Ada'}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(width: 10),
            Text(
              'Isi Open Item: ${OpenItemDetail['isi'] ?? 'Tidak Ada'}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
