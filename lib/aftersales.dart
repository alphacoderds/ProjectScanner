import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';

class AfterSales extends StatefulWidget {
  const AfterSales({super.key});

  @override
  State<AfterSales> createState() => _AfterSalesState();
}

class _AfterSalesState extends State<AfterSales> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Dialog(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(43, 56, 86, 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Apakah produk berjalan sesuai dengan semestinya?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _dialog2();
                              },
                            );
                          },
                          child: const SizedBox(
                              width: 40,
                              height: 30,
                              child: Center(
                                child: Text(
                                  "ya",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPrimary: Color.fromRGBO(43, 56, 86, 1),
                            primary: Colors.white,
                          )),
                      SizedBox(width: 50),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NavBar()),
                            );
                          },
                          child: const SizedBox(
                              width: 40,
                              height: 30,
                              child: Center(
                                child: Text(
                                  "tidak",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPrimary: Color.fromRGBO(43, 56, 86, 1),
                            primary: Colors.white,
                          ))
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        }
        return Dialog();
      },
    );
  }

  Widget _dialog2() {
    return Dialog(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(43, 56, 86, 1),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Menyimpan data!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NavBar()),
                        );
                      },
                      child: const SizedBox(
                          width: 60,
                          height: 30,
                          child: Center(
                            child: Text(
                              "Kembali",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          )),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPrimary: Color.fromRGBO(43, 56, 86, 1),
                        primary: Colors.white,
                      )),
                  SizedBox(height: 50),
                ])));
  }
}
