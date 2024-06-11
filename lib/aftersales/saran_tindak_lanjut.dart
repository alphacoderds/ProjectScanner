import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'tambahsaran.dart';
import 'viewsaran.dart';
import 'aftersales.dart';

class ListSaran extends StatefulWidget {
  final String id_project;
  const ListSaran({Key? key, required this.id_project}) : super(key: key);

  @override
  State<ListSaran> createState() => _ListSaranState();
}

class _ListSaranState extends State<ListSaran> {
  late double screenWidth;
  late double screenHeight;

  List<dynamic> _listdata = [];
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
            'http://192.168.8.207/ProjectScanner/lib/aftersales/get_saran.php?id_lot=${widget.id_project}'),
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

  Future<void> _refreshData() async {
    await _getdata();
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
              MaterialPageRoute(
                  builder: (context) => AfterSalesData(
                        id_project: widget.id_project,
                      )),
            );
          },
        ),
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: _ListView(),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_rounded,
          size: 40,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahSaran(
                id_project: widget.id_project,
              ),
            ),
          );
          _refreshData(); // Refresh the data after returning from TambahSaran
        },
      ),
    );
  }

  Widget _ListView() {
    List filteredData = _listdata.where((data) {
      String saran = data['saran'] ?? '';
      return saran.toLowerCase().contains(_searchQuery.toLowerCase());
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
                  "saran": projectData['saran'],
                  "waktu_saran": projectData['waktu_saran'],
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
            height: 2,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSaran(
                    selectedProject: {
                      "saran": projectData['saran'],
                      "waktu_saran": projectData['waktu_saran'],
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 0),
              child: Container(
                width: screenWidth * 0.9,
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
                    const SizedBox(height: 1),
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
