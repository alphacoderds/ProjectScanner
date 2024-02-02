import 'package:flutter/material.dart';

class MenuRiwayatScan extends StatefulWidget {
  const MenuRiwayatScan({Key? key}) : super(key: key);

  @override
  State<MenuRiwayatScan> createState() => _RiwayatScanState();
}

class _RiwayatScanState extends State<MenuRiwayatScan> {
  // Define a list of texts
  final List<String> riwayatTexts = [
    'Penerimaan Product',
    'Material',
    'After Seles',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Riwayat Scan'),
            SizedBox(width: 10.0),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionalTranslation(
                  translation:
                      Offset(0.37, 0.10), // Sesuaikan offset sesuai kebutuhan
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
      body: ListView.builder(
        itemCount: 4, // Sesuaikan dengan jumlah item yang diinginkan
        itemBuilder: (context, index) {
          if (index == 2) {
            // Add empty container after the third container
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xBF2B3856),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            '${riwayatTexts[index]}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20), // Adjust the height as needed
              ],
            );
          }

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xBF2B3856),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      '${riwayatTexts[index]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
