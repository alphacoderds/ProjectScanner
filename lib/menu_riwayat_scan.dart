import 'package:flutter/material.dart';

class MenuRiwayatScan extends StatefulWidget {
  const MenuRiwayatScan({Key? key}) : super(key: key);

  @override
  State<MenuRiwayatScan> createState() => _MenuRiwayatScanState();
}

class _MenuRiwayatScanState extends State<MenuRiwayatScan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Riwayat Scan'),
              SizedBox(width: 20.0),
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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01,
            horizontal: screenWidth * 0.05,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanRiwayatProduk(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.033,
                  horizontal: screenWidth * 0.045,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Penerimaan Product',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.012,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanRiwayatMaterial(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.033,
                  horizontal: screenWidth * 0.045,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Material',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.012,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanRiwayatAfterSales(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.033,
                  horizontal: screenWidth * 0.045,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'After Sales',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
