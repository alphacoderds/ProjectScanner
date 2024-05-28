import 'package:RekaChain/kerusakan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
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
          'http://192.168.9.60/ProjectScanner/lib/API/get_kerusakan.php?id_project=${widget.id_project}'));
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
        child: Icon(Icons.add_rounded, size: 40, color: Colors.white,),
        backgroundColor: const Color.fromARGB(255, 14, 26, 44),
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
        child: ListTile(
          title: Text(
            'Kode Produk: ${kerusakanData['id_project'] ?? 'Tidak Ada'}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Kerusakan: ${kerusakanData['detail_kerusakan'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                'Item: ${kerusakanData['item'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                'Keterangan: ${kerusakanData['keterangan'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              // Text(
              //   'Tanggal: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(kerusakanData['tanggal']!))}',
              //   style: TextStyle(fontSize: 12),
              // ),
              Text(
                'Tanggal: ${kerusakanData['waktu'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 12),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Detail Kerusakan: ${kerusakanDetail['detail_kerusakan'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'Item: ${kerusakanDetail['item'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'Keterangan: ${kerusakanDetail['keterangan'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            // Text(
            //   'Tanggal: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(kerusakanDetail['tanggal']!))}',
            //   style: TextStyle(fontSize: 12),
            // ),
            Text(
              'Tanggal: ${kerusakanDetail['waktu'] ?? 'Tidak Ada'}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// class TambahKerusakan extends StatefulWidget {
//   final Function(Map<String, String> data) onSaved;
//   final String id_project;
//   const TambahKerusakan(
//       {Key? key, required this.onSaved, required this.id_project})
//       : super(key: key);

//   @override
//   State<TambahKerusakan> createState() => _TambahKerusakanState();
// }

// class _TambahKerusakanState extends State<TambahKerusakan> {
//   late TextEditingController _noController;
//   late TextEditingController _detailKerusakanController;
//   late TextEditingController _itemController;
//   late TextEditingController _keteranganController;

//   @override
//   void initState() {
//     super.initState();
//     _noController = TextEditingController(text: widget.id_project);
//     _detailKerusakanController = TextEditingController();
//     _itemController = TextEditingController();
//     _keteranganController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tambah/Edit Kerusakan'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'Isi Data Kerusakan',
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20.0),
//               TextField(
//                 controller: _noController,
//                 decoration: InputDecoration(
//                   labelText: 'Kode Produk',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 12.0),
//               TextField(
//                 controller: _detailKerusakanController,
//                 decoration: InputDecoration(
//                   labelText: 'Detail Kerusakan',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 5,
//               ),
//               SizedBox(height: 12.0),
//               TextField(
//                 controller: _itemController,
//                 decoration: InputDecoration(
//                   labelText: 'Item',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 12.0),
//               TextField(
//                 controller: _keteranganController,
//                 decoration: InputDecoration(
//                   labelText: 'Keterangan',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 5,
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: _saveData,
//                 child: Text('Simpan'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveData() {
//     final newData = {
//       'id_project': _noController.text,
//       'detail_kerusakan': _detailKerusakanController.text,
//       'item': _itemController.text,
//       'keterangan': _keteranganController.text,
//     };
//     widget.onSaved(newData);
//   }

//   @override
//   void dispose() {
//     _noController.dispose();
//     _detailKerusakanController.dispose();
//     _itemController.dispose();
//     _keteranganController.dispose();
//     super.dispose();
//   }
// }
