import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';

class PopUpMaterial extends StatefulWidget {
  const PopUpMaterial({Key? key}) : super(key: key);

  @override
  State<PopUpMaterial> createState() => _PopUpMaterialState();
}

class _PopUpMaterialState extends State<PopUpMaterial> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

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
                width: screenWidth * 0.8,
                height: screenHeight * 0.25,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(43, 56, 86, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 21),
                    const Text(
                      'Apakah material sudah bisa\nditerima sesuai checklist?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
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
                            primary: Colors.white,
                            onPrimary: const Color.fromRGBO(43, 56, 86, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.012,
                              bottom: screenHeight * 0.012,
                              left: screenWidth * 0.0035,
                              right: screenWidth * 0.0035,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _dialog3();
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: const Color.fromRGBO(43, 56, 86, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.012,
                              bottom: screenHeight * 0.012,
                              left: screenWidth * 0.003,
                              right: screenWidth * 0.003,
                            ),
                            child: Text(
                              "Tidak",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
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
              'Material akan diproses!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
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
                primary: Colors.white,
                onPrimary: const Color.fromRGBO(43, 56, 86, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.012,
                  bottom: screenHeight * 0.012,
                  left: screenWidth * 0.003,
                  right: screenWidth * 0.003,
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(43, 56, 86, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 31),
            const Text(
              'Apakah material tetap diterima\nwalaupun tidak lengkap?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 31),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    primary: Colors.white,
                    onPrimary: const Color.fromRGBO(43, 56, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.012,
                      bottom: screenHeight * 0.012,
                      left: screenWidth * 0.0035,
                      right: screenWidth * 0.0035,
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
                const SizedBox(width: 25),
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
                    primary: Colors.white,
                    onPrimary: const Color.fromRGBO(43, 56, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.012,
                      bottom: screenHeight * 0.012,
                      left: screenWidth * 0.003,
                      right: screenWidth * 0.003,
                    ),
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 31),
          ],
        ),
      ),
    );
  }

  Widget _dialog4() {
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
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 100,
            ),
            const Text(
              'Menyimpan data!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
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
                primary: Colors.white,
                onPrimary: const Color.fromRGBO(43, 56, 86, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.012,
                  bottom: screenHeight * 0.012,
                  left: screenWidth * 0.003,
                  right: screenWidth * 0.003,
                ),
                child: Text(
                  "Kembali",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
