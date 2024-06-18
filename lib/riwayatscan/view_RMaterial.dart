import 'dart:convert';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:http/http.dart' as http;
import 'package:RekaChain/ModelClass/MD_ScanMaterial.dart';
import 'package:flutter/material.dart';

class ViewRiwayatMaterial extends StatefulWidget {
  final String kodeLot;
  const ViewRiwayatMaterial({super.key, required this.kodeLot});

  @override
  State<ViewRiwayatMaterial> createState() => _ViewRiwayatMaterialState();
}

class _ViewRiwayatMaterialState extends State<ViewRiwayatMaterial> {
  late double screenWidth;
  late double screenHeight;

  late ScanMaterial scanmaterial;
  late List _listdata;
  bool _isloading = true;

  String idProject = '';
  String nama = '';

  TextEditingController qtyDiterima = TextEditingController();
  late List<List<TextEditingController>> controllers;

  Map<int, String> _temporaryChanges = {};

  Future<void> fetchData() async {
    setState(() {
      _isloading = true; // Set loading indicator to true while fetching data
    });
    final Uri url = Uri.parse(
        'http://10.208.204.53/ProjectScanner/lib/riwayatscan/READ_RMaterial.php?kodeLot=${widget.kodeLot}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _listdata = responseData.cast<
              Map<String, dynamic>>(); // Update _listdata with fetched data
          if (_listdata.isNotEmpty) {
            idProject = _listdata[0]['id_project'].toString();
            nama = _listdata[0]['nama'].toString();
          }
          _isloading =
              false; // Set loading indicator to false after fetching data
        });
      } catch (e) {
        print('Error decoding JSON: $e');
        setState(() {
          _isloading =
              false; // Set loading indicator to false if JSON decoding fails
        });
        throw Exception('Failed to parse JSON');
      }
    } else {
      setState(() {
        _isloading = false; // Set loading indicator to false if request fails
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    controllers = [];
    _scrollController = ScrollController();
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NavBar()));
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Scan Riwayat Material"),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionalTranslation(
                  translation: Offset(0.37, 0.10),
                  child: AspectRatio(
                    aspectRatio: 11 / 8,
                    child: Image.asset(
                      'assets/images/bolder31.png',
                      width: screenWidth * 0.4,
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
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Nama Project : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextSpan(
                            text: '$idProject',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Kode Lot : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextSpan(
                            text: '${widget.kodeLot}',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Penerima : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          TextSpan(
                            text: '$nama',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - 50,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 20.0,
                              horizontalMargin: 20.0,
                              columns: [
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      'Kode\nMaterial',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      'Deskripsi',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      'Satuan',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      'QTY',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Center(
                                    child: Text(
                                      'QTY\nDiterima',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                              rows: _listdata.asMap().entries.map((entry) {
                                final int index = entry.key;
                                final Map<String, dynamic> data = entry.value;
                                return DataRow(cells: [
                                  DataCell(
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                            data['kodeMaterial'].toString()),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child:
                                            Text(data['deskripsi'].toString()),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child:
                                            Text(data['specTech'].toString()),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(data['qty'].toString()),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(data['unit'].toString()),
                                      ),
                                    ),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
