import 'dart:convert';
import 'package:RekaChain/ModelClass/MD_ScanMaterial.dart';
import 'package:RekaChain/provider/user_provider.dart';
import 'package:RekaChain/scanmaterial/pop_up_materiall.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabelScanMaterial extends StatefulWidget {
  final String kodeLot;
  const TabelScanMaterial({Key? key, required this.kodeLot}) : super(key: key);
  @override
  State<TabelScanMaterial> createState() => _TabelScanMaterialState();
}

class _TabelScanMaterialState extends State<TabelScanMaterial> {
  late double screenWidth;
  late double screenHeight;
  late ScanMaterial scanmaterial;
  late List _listdata;
  bool _isloading = true;

  TextEditingController qtyDiterima = TextEditingController();
  late List<List<TextEditingController>> controllers;

  Map<int, String> _temporaryChanges = {};

  Future<void> fetchData() async {
    setState(() {
      _isloading = true; // Set loading indicator to true while fetching data
    });
    final Uri url = Uri.parse(
        'http://192.168.11.164/ProjectScanner/lib/scanmaterial/READ_ScanMaterial.php?kodeLot=${widget.kodeLot}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _listdata = responseData.cast<
              Map<String, dynamic>>(); // Update _listdata with fetched data
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

  void _updateQtyDiterima(int index, String newQtyDiterima) {
    setState(() {
      _temporaryChanges[index] = newQtyDiterima;
    });
  }

  void _saveChanges() async {
    for (var entry in _temporaryChanges.entries) {
      int index = entry.key;
      String newQtyDiterima = entry.value;
      await _updateQtyDiterimaInDatabase(index, newQtyDiterima);
    }
  }

  Future<void> _updateQtyDiterimaInDatabase(
      int index, String newQtyDiterima) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String nip = userProvider.dataModel.nip;

    final Map<String, dynamic> requestData = {
      'no': _listdata[index]['no'],
      'unit': newQtyDiterima,
      'nip': nip,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.11.164/ProjectScanner/lib/scanmaterial/UPDATE_ScanMaterial.php'),
        body: requestData,
      );

      if (response.statusCode != 200) {
        print('Failed to update qty_diterima: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating qty_diterima: $e');
    }
  }

  late ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String nip = userProvider.dataModel.nip;

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('NIP: $nip'),
            SizedBox(width: screenWidth * 0.6),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionalTranslation(
                  translation: Offset(0.37, 0.10),
                  child: AspectRatio(
                    aspectRatio: 11 / 8,
                    child: Image(
                      image: AssetImage('assets/images/bolder31.png'),
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
              child: Container(
                alignment: Alignment.center,
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
                                'ID',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'KodeLot',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Deskripsi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Satuan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'QTY',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'QTY\nDiterima',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                  child: Text(data['no'].toString()),
                                ),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(data['kodeLot'].toString()),
                                ),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(data['deskripsi'].toString()),
                                ),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(data['specTech'].toString()),
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
                              TextFormField(
                                initialValue:
                                    _listdata[index]['unit'].toString(),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _updateQtyDiterima(index, value);
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          size: 30,
          color: Color.fromRGBO(43, 56, 86, 1),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Color.fromRGBO(43, 56, 86, 1), width: 2),
        ),
        onPressed: () {
          for (var controllerList in controllers) {
            for (var controller in controllerList) {
              print(controller.text);
            }
          }
          setState(() {
            controllers.add([
              for (int k = 0; k < 6; k++) TextEditingController(),
            ]);
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PopUpMaterial(saveChangesCallback: _saveChanges)),
          );
        },
      ),
    );
  }
}
