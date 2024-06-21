import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:RekaChain/tahapselesai/tambahopenitem.dart';

class ListClose extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_openlist;
  const ListClose({Key? key, this.newProject, required this.id_openlist})
      : super(key: key);

  @override
  State<ListClose> createState() => _ListCloseState();
}

class _ListCloseState extends State<ListClose> {
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
          'http://192.168.10.102/ProjectScanner/lib/tahapselesai/read_openlist.php?id_openlist=${widget.id_openlist}'));
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
        title: Text('List Close Item'),
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
                return _buildDismissibleItem(_OpenItem[index], index);
              },
            ),
    );
  }

  Widget _buildDismissibleItem(Map<String, dynamic> OpenItemData, int index) {
    return Dismissible(
      key: Key(OpenItemData['no'].toString()),
      direction: DismissDirection
          .endToStart, // Change to endToStart for swipe left to delete
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text("Konfirmasi"),
              ),
              content: Center(
                child: Text("Apakah Anda yakin ingin menghapus item ini?"),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Ya"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Tidak"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        _deleteOpenItem(OpenItemData['no'].toString());
      },
      child: _buildOpenItemCard(OpenItemData),
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
        ),
      ),
    );
  }

  void _deleteOpenItem(String id) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://192.168.10.102/ProjectScanner/lib/tahapselesai/delete_openlist.php',
        ),
        body: {
          'no': id,
        },
      );

      print('Delete response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
      } else {
        print('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
