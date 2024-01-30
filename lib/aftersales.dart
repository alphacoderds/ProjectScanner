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
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Dialog(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(43, 56, 86, 1),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      'Apakah produk berjalan sesuai dengan semestinya?',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 40),
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
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromRGBO(43, 56, 86, 1),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))),
                        const SizedBox(width: 50),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NavBar()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  const Color.fromRGBO(43, 56, 86, 1),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }
          return const Dialog();
        },
      ),
    );
  }

  Widget _dialog2() {
    return Dialog(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(43, 56, 86, 1),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Menyimpan data!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
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
                          ))),
                  const SizedBox(height: 50),
                ])));
  }
}
