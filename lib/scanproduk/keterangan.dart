import 'dart:convert';

import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/scanproduk/viewKeterangan.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/scanproduk/tambah_keterangan.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Keterangan extends StatefulWidget {
  final String id_lot;
  final Map<String, dynamic>? newProject;
  const Keterangan({super.key, required this.id_lot, this.newProject});

  @override
  State<Keterangan> createState() => _KeteranganState();
}

class _KeteranganState extends State<Keterangan> {
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
        Uri.parse(
            'http://192.168.8.207/ProjectScanner/lib/API/read_keterangan.php?id_lot=${widget.id_lot}'),
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
        title: const Text('Keterangan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/bolder32.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _ListView(),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TambahKeterangan(
                            id_lot: widget.id_lot,
                          )),
                );
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ListView() {
    List filteredData = _listdata.where((data) {
      String keterangan = data['keterangan_produk'] ?? '';
      return keterangan.toLowerCase().contains(_searchQuery.toLowerCase());
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
              builder: (context) => ViewKeterangan(
                id_lot: widget.id_lot,
                selectedProject: {
                  "id_lot": projectData['id_lot'],
                  "keterangan_produk": projectData['keterangan_produk'],
                },
              ),
            ),
          ).then((value) => _getdata());
        },
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
                    builder: (context) => ViewKeterangan(
                      id_lot: widget.id_lot,
                      selectedProject: {
                        "id_lot": projectData['id_lot'],
                        "keterangan_produk": projectData['keterangan_produk']
                      },
                    ),
                  ));
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.8, horizontal: 7.0),
              child: Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${projectData['keterangan_produk']} ',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
