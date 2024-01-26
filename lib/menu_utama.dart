import 'package:flutter/material.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("REKA CHAIN",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      "Selamat Datang...",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(right: -20),
                child: Image.asset(
                  'assets/images/bolder32.png',
                  width: 200,
                  alignment: Alignment.topRight,
                ),
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Color.fromRGBO(85, 100, 136, 1),
                        child: Icon(
                          Icons.move_to_inbox_rounded,
                          color: Color.fromRGBO(43, 56, 86, 1),
                          size: 70,
                        ),
                      ),
                      Text(
                        "Scan Produk",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 30),
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Color.fromRGBO(85, 100, 136, 1),
                        child: Icon(
                          Icons.description_outlined,
                          color: Color.fromRGBO(43, 56, 86, 1),
                          size: 70,
                        ),
                      ),
                      Text(
                        "Download \nDocument",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
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
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Color.fromRGBO(85, 100, 136, 1),
                        child: Icon(
                          Icons.assignment_turned_in_outlined,
                          color: Color.fromRGBO(43, 56, 86, 1),
                          size: 70,
                        ),
                      ),
                      Text(
                        "Cek Status \n   Produk",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(43, 56, 86, 1),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
