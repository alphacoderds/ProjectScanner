import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:http/http.dart' as http;

class ListCloseItem extends StatefulWidget {
  final String kodeLot;
  const ListCloseItem({super.key, required this.kodeLot});

  @override
  State<ListCloseItem> createState() => _ListCloseItemState();
}

class _ListCloseItemState extends State<ListCloseItem> {
  List<Map<String, dynamic>> _listItems = [];

  @override
  void initState() {
    super.initState();
    _fetchOpenItems();
  }

  Future<void> _fetchOpenItems() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.8.121/ProjectScanner/lib/API/read_openlist.php?kodeLot=${widget.kodeLot}'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          _listItems =
              data.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _markItemAsClosed(int index) async {
    final item = _listItems[index];
    final response = await http.post(
      Uri.parse(
          'http://192.168.8.121/ProjectScanner/lib/API/update_item_status.php'),
      body: {'no': item['no'].toString()},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success']) {
        setState(() {
          _listItems.removeAt(index);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('List Close Item'),
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
      body: ListView.builder(
        itemCount: _listItems.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54, width: 2)),
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _listItems[index]['isi'],
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        _markItemAsClosed(index);
                      },
                      icon: Icon(
                        Icons.check_box_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.check,
            size: 40,
            color: Color.fromRGBO(43, 56, 86, 1),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Color.fromRGBO(43, 56, 86, 1), width: 2),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavBar(),
              ),
            );
          }),
    );
  }
}
