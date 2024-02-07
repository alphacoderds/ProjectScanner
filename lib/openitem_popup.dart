import 'package:flutter/material.dart';
import 'package:RekaChain/open_item.dart';

class OIPopup1 extends StatefulWidget {
  const OIPopup1({super.key});

  @override
  State<OIPopup1> createState() => _OIPopup1State();
}

class _OIPopup1State extends State<OIPopup1> {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 0)),
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
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.white,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Menyimpan data!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
                      child: const SizedBox(
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Selesai",
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
          return const Dialog();
        },
      ),
    );
  }
}
