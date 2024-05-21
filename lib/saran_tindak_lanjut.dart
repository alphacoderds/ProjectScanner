import 'dart:convert';

import 'package:RekaChain/tambahsaran.dart';
import 'package:RekaChain/viewsaran.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/aftersales.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ListSaran extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  const ListSaran({Key? key, this.newProject}) : super(key: key);

  @override
  State<ListSaran> createState() => _ListSaranState();
}

class _ListSaranState extends State<ListSaran> {
  late double screenWidth;
  late double screenHeight;

  late List<dynamic> _listdata = [];
  bool _isloading = true;

  String _searchQuery = '';

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _getdata() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.8.107/ProjectScanner/lib/API/get_saran.php'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      } else {
        setState(() {
          _isloading = false;
        });
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('List Saran/Tindak lanjut'),
            SizedBox(width: 10.0),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionalTranslation(
                  translation: Offset(0.37, 0.10),
                  child: AspectRatio(
                    aspectRatio: 11 / 8,
                    child: Image(
                      image: AssetImage('assets/images/bolder31.png'),
                      width: 170,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AfterSalesData()),
            );
          },
        ),
      ),

      // body: ListView.builder(
      //   itemCount: 8,
      //   itemBuilder: (context, index) {
      //     return GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ViewSaran(
      //                 selectedProject: {
      //                   'id': index,
      //                   'kode_produk': 'Kode Produk $index',
      //                   'saran': 'Saran $index',
      //                   'waktu': DateFormat('dd/MM/yyyy HH:mm')
      //                       .format(DateTime.now()),
      //                 },
      //               ),
      //             ),
      //           );
      //         },
      //         child: Padding(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: const Color(0xBF2B3856),
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             padding: const EdgeInsets.all(15.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Saran/Tindak Lanjut ${index + 1}',
      //                   style: const TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 18,
      //                     fontFamily: 'Inter',
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 10),
      //                 Text(
      //                   DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
      //                   style: const TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 16,
      //                     fontFamily: 'Inter',
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ));
      //   },
      // ),
      body: _ListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add_rounded,
            size: 40,
            weight: 60,
          ),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahSaran(),
              ),
            );
          }),
    );
  }

  Widget _ListView() {
    List filteredData = _listdata.where((data) {
      String kode_produk = data['kode_produk'] ?? '';
      return kode_produk.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return ListView.separated(
      itemBuilder: (context, index) {
        return ListViewItem(context, index, filteredData[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 0);
      },
      itemCount: filteredData.length,
    );
  }

  Widget ListViewItem(BuildContext context, int index, dynamic projectData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewSaran(
                selectedProject: {
                  "kode_produk": projectData['kode_produk'],
                  "saran": projectData['saran'],
                  "waktu": projectData['waktu'],
                },
              ),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    message(context, projectData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget message(BuildContext context, dynamic projectData) {
    double textsize = 14;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSaran(
                    selectedProject: {
                      "kode_produk": projectData['kode_produk'],
                      "saran": projectData['saran'],
                      "waktu": projectData['waktu'],
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
              child: Container(
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${projectData['saran']} ',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm')
                          .format(DateTime.parse(projectData['waktu'])),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
