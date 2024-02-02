import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'dart:js_util';

class ListCloseItem extends StatefulWidget {
  const ListCloseItem({super.key});

  @override
  State<ListCloseItem> createState() => _ListCloseItemState();
}

class _ListCloseItemState extends State<ListCloseItem> {
  List<String> _listItems = [
    'Open Item 1',
    'Open Item 2',
    'Open Item 3',
    'Open Item 4',
    'Open Item 5',
    'Open Item 6',
    'Open Item 7',
    'Open Item 8'
  ];

  void _deleteItem(int index) {
    setState(() {
      _listItems = _listItems
          .where((item) => _listItems.indexOf(item) != index)
          .toList();
    });
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
                    Text(
                      _listItems[index],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {
                          _deleteItem(index);
                        },
                        icon: Icon(
                          Icons.check_box_outlined,
                          color: Colors.green,
                        ))
                  ],
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.check,
            size: 40,
            weight: 60,
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
