import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:RekaChain/unduhberkas/detailunduh_berkas.dart';

class Unduh extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_project;

  const Unduh({Key? key, this.newProject, required this.id_project})
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
          'http://192.168.10.102/ProjectScanner/lib/unduhberkas/get_unduh.php?id_project=${widget.id_project}'));
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
            'Kode Produk: ${unduhData['id_project'] ?? 'Tidak Ada'}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No Produk: ${unduhData['noProduk'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal: ${unduhData['waktu'] ?? 'Tidak Ada'}',
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




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Berkas'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 0.0),
//             child: GestureDetector(
//               onTap: () {},
//               child: Image.asset(
//                 'assets/images/bolder32.png',
//                 width: 60,
//                 height: 60,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => detailunduh()),
//               );
//             },
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xBF2B3856),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 padding: const EdgeInsets.all(15.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         'Dokumen ${index + 1}',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => detailunduh()),
//                         );
//                       },
//                       child: Text(
//                         'Unduh',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
