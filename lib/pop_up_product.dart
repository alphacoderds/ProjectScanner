import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/keterangan.dart';

class PopUpProduk extends StatefulWidget {
  const PopUpProduk({Key? key}) : super(key: key);

  @override
  State<PopUpProduk> createState() => _PopUpProdukState();
}

class _PopUpProdukState extends State<PopUpProduk> {
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
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Apakah produk bisa diterima?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
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
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NavBar(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                const Color.fromRGBO(43, 56, 86, 1),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
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
            const SizedBox(height: 10),
            const Text(
              'Apakah produk dapat mulai dikerjakan?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _dialog3();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Keterangan(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _dialog3() {
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
            const Text(
              'Semangat memulai pekerjaan Anda !',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavBar(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(43, 56, 86, 1),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                width: 40,
                height: 30,
                child: Center(
                  child: Text(
                    "Mulai",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
