import 'package:flutter/material.dart';

class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("REKA CHAIN",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  "Selamat Datang...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ]),
          Image.asset(
            'assets/images/bolder32.png',
            width: 200,
            alignment: Alignment.topRight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(85, 100, 136, 1),
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  Text(
                    "Scan Material",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 40),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(85, 100, 136, 1),
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  Text(
                    "Scan Produk",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(85, 100, 136, 1),
                    child: Icon(
                      Icons.edit_document,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  Text(
                    "Download Document",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 40),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromRGBO(85, 100, 136, 1),
                    child: Icon(
                      Icons.check_box_outlined,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  Text(
                    "Cek Status Produk",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
