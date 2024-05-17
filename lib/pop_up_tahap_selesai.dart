import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/close_item.dart';
import 'package:RekaChain/open_item.dart';
import 'package:RekaChain/scan_tahap_selesai.dart';

class PopUpTahapSelesai extends StatefulWidget {
  const PopUpTahapSelesai({Key? key}) : super(key: key);

  @override
  State<PopUpTahapSelesai> createState() => _PopUpTahapSelesaiState();
}

class _PopUpTahapSelesaiState extends State<PopUpTahapSelesai> {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Dialog(
              alignment: Alignment.center,
              child: Container(
                width: screenWidth * 0.8,
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
                      'Apakah produk sudah selesai diperoses?',
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
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.012,
                              bottom: screenHeight * 0.012,
                              left: screenWidth * 0.035,
                              right: screenWidth * 0.05,
                            ),
                            child: Text(
                              "Ya",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavBar(),
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
                            width: 50,
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
        width: screenWidth * 0.8,
        height: screenHeight * 0.3,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(43, 56, 86, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Apakah ada open item?',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListOpenItem(),
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.012,
                      bottom: screenHeight * 0.012,
                      left: screenWidth * 0.035,
                      right: screenWidth * 0.05,
                    ),
                    child: Text(
                      "Ya",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _dialog4();
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
                    height: 40,
                    width: 45,
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
            const SizedBox(height: 10),
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
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    "Close Open Item",
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

  Widget _dialog3() {
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.3,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(43, 56, 86, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Close open item ?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListCloseItem(),
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.012,
                      bottom: screenHeight * 0.012,
                      left: screenWidth * 0.035,
                      right: screenWidth * 0.05,
                    ),
                    child: Text(
                      "Ya",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _dialog4();
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
                    height: 40,
                    width: 45,
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

  Widget _dialog4() {
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.35,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(43, 56, 86, 1),
          borderRadius: BorderRadius.circular(20),
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
              '\nMenyimpan data!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
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
                width: 50,
                height: 40,
                child: Center(
                  child: Text(
                    "Done",
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
