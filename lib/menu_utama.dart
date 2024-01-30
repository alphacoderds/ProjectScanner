import 'package:flutter/material.dart';
import 'package:flutter_scanner/aftersales.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 315),
            child: Image.asset(
              'assets/images/bolder32.png',
              width: 150,
            ),
          ),
          const SizedBox(height: 20),
          const Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "REKA CHAIN",
                      style: TextStyle(
                          fontFamily: 'Donegal One',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Selamat Datang...",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40), // Add some space between the text and image
          const Stack(
            alignment: Alignment.topRight,
          ),
          const SizedBox(height: 20), // Add some space between the image and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(85, 100, 136, 1),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Scan Material",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(85, 100, 136, 1),
                    child: const Icon(
                      Icons.move_to_inbox_rounded,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Scan Produk",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(85, 100, 136, 1),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Scan Produk",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 20), // Add some space between the button rows
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(85, 100, 136, 1),
                    child: const Icon(
                      Icons.description_outlined,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Download \nDocument",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AfterSales()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Color.fromRGBO(85, 100, 136, 1),
                      child: Icon(
                        Icons.headset_mic,
                        color: Color.fromRGBO(43, 56, 86, 1),
                        size: 70,
                      ),
                    ),
                    Text(
                      "After Seles",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromRGBO(85, 100, 136, 1),
                    child: const Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Color.fromRGBO(43, 56, 86, 1),
                      size: 70,
                    ),
                  ),
                  const Text(
                    "Cek Status \n   Produk",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
