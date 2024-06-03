import 'dart:convert';

import 'package:RekaChain/tahapselesai/listopenitem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewOI extends StatefulWidget {
  final String kodeLot;
  final Map<String, dynamic> selectedProject;
  const ViewOI(
      {Key? key, required this.kodeLot, this.selectedProject = const {}})
      : super(key: key);

  @override
  State<ViewOI> createState() => _ViewOIState();
}

class _ViewOIState extends State<ViewOI> {
  TextEditingController isiopenitemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    isiopenitemController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.10.230/ProjectScanner/lib/API/edit_openitem.php?no=${widget.selectedProject['no']}&isi=${widget.selectedProject['isi']}'),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final isi = responseData['isi'];
        setState(() {
          isiopenitemController.text = responseData['isi'] ?? '';
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _updateDataAndNavigateToListProject() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.8.153/ProjectScanner/lib/API/edit_openitem.php'),
        body: {
          'no': widget.selectedProject['no'].toString(),
          'isi': isiopenitemController.text,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ListOI(
                    kodeLot: widget.kodeLot,
                  )),
        );
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Open Item'),
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  controller: isiopenitemController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Isi Open Item',
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  minLines: 4,
                  maxLines: null,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: IconButton(
            onPressed: () {
              _updateDataAndNavigateToListProject();
            },
            icon: Icon(
              Icons.check_box_outlined,
              size: 40,
            ),
          ),
        ),
      ]),
    );
  }

//======================================Tampilan Pop Up Simpan Data 1======================================
  Widget _oipopupsimpan1() {
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
                _updateDataAndNavigateToListProject();
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
}
