import 'dart:convert';

import 'package:RekaChain/tahapselesai/openitemView.dart';
import 'package:RekaChain/tbl_tambahstaff/tambahopenitem.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/tahapselesai/scan_tahap_selesai.dart';
import 'package:http/http.dart' as http;

//======================================Tampilan List Open Item======================================
class ListOI extends StatefulWidget {
  final String kodeLot;
  final Map<String, dynamic>? newProject;

  const ListOI({Key? key, this.newProject, required this.kodeLot})
      : super(key: key);

  @override
  State<ListOI> createState() => _ListOIState();
}

class _ListOIState extends State<ListOI> {
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
            'http://192.168.10.230/ProjectScanner/lib/API/read_openlist.php?kodeLot=${widget.kodeLot}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data.where((item) => item['status'] != 'closed').toList();
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

  Future<void> _markItemAsClosed(int index) async {
    final item = _listdata[index];
    final response = await http.post(
      Uri.parse(
          'http://192.168.10.230/ProjectScanner/lib/API/update_item_status.php'),
      body: {'no': item['no'].toString()},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success']) {
        setState(() {
          _listdata.removeAt(index);
        });
        print('Item marked as closed.');
      } else {
        print('Failed to update item status: ${result['error']}');
      }
    } else {
      print('Failed to update item status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('List Open Item'),
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
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _searchQuery.isEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _listdata.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListViewItem(context, index, _listdata[index]),
                                Divider(), // Add Divider here
                              ],
                            );
                          },
                        ),
                      )
                    : Expanded(child: _ListView()),
              ],
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Text('Next',
                style: TextStyle(fontSize: 17, color: Colors.white),
                textAlign: TextAlign.center),
            backgroundColor: Color.fromRGBO(43, 56, 86, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _oipopuplanjut();
                },
              );
            },
          ),
          SizedBox(width: 150),
          FloatingActionButton(
            child: Icon(
              Icons.add_rounded,
              size: 40,
              weight: 60,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(43, 56, 86, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TambahOpenItem(kodeLot: widget.kodeLot);
                },
              ).then((_) => _getdata());
            },
          ),
        ],
      ),
    );
  }

//======================================Tampilan Pop Up Produk DIlanjutkan Atau TIdak======================================
  Widget _oipopuplanjut() {
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(43, 56, 86, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Apakah produk tetap dilanjutkan?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _oipopupsimpan2();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const SizedBox(
                    width: 40,
                    height: 30,
                    child: Center(
                      child: Text(
                        "Ya",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScannerTahapSelesai(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const SizedBox(
                    width: 40,
                    height: 30,
                    child: Center(
                      child: Text(
                        "Tidak",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

//======================================Tampilan Pop Up Simpan Data 2======================================
  Widget _oipopupsimpan2() {
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(43, 56, 86, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              'Menyimpan data!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavBar(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                width: 50,
                height: 30,
                child: Center(
                  child: Text(
                    "Selesai",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _ListView() {
    final filteredData = _listdata.where((item) {
      final searchLower = _searchQuery.toLowerCase();
      final kodeLower = item['kode'].toString().toLowerCase();
      final isiLower = item['isi'].toString().toLowerCase();
      return kodeLower.contains(searchLower) || isiLower.contains(searchLower);
    }).toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListViewItem(context, index, filteredData[index]),
            Divider(),
          ],
        );
      },
    );
  }

  Widget ListViewItem(BuildContext context, int index, dynamic data) {
    return ListTile(
      title: Text(data['isi']),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ViewOI(kodeLot: widget.kodeLot, selectedProject: data),
          ),
        );
      },
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${projectData['isi']} ',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
