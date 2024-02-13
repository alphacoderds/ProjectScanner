import 'package:flutter/material.dart';

class TabelScanMaterial extends StatefulWidget {
  const TabelScanMaterial({super.key});

  @override
  State<TabelScanMaterial> createState() => _TabelScanMaterialState();
}

class _TabelScanMaterialState extends State<TabelScanMaterial> {
  late double screenWidth;
  late double screenHeight;

  late ScrollController _scrollController;
  List<List<TextEditingController>> controllers = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    controllers.add([
      for (int i = 0; i < 6; i++) TextEditingController(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: screenWidth * 0.6),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionalTranslation(
                  translation: Offset(0.37, 0.10),
                  child: AspectRatio(
                    aspectRatio: 11 / 8,
                    child: Image(
                      image: AssetImage('assets/images/bolder31.png'),
                      width: screenWidth * 0.4,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.05, horizontal: screenWidth * 0.01),
        child: Column(
          children: [
            Text('Checklist', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        child: Text(
                          'Kode\nMaterial',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        child: Text(
                          'Deskripsi',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        child: Text(
                          'Satuan',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        child: Text(
                          'QYT',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      TableCell(
                          child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        child: Text(
                          'QYT/Diterima',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                    ]),
                    for (int i = 0; i < controllers.length; i++)
                      TableRow(children: [
                        for (int j = 0; j < controllers[i].length; j++)
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.005),
                              child: TextField(
                                controller: controllers[i][j],
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01,
                                      horizontal: screenWidth * 0.01),
                                ),
                                onChanged: (value) {
                                  // Tambah baris jika baris terakhir terisi
                                  if (j == controllers[i].length - 1 &&
                                      value.isNotEmpty) {
                                    setState(() {
                                      controllers.add([
                                        for (int k = 0; k < 6; k++)
                                          TextEditingController(),
                                      ]);
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                      ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
