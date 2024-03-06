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

  static Map<String, String> createDataRow() {
    return {
      'no': '',
      'kodeMaterial': '',
      'deskripsi': '',
      'satuan': '',
      'qyt': '',
      'qytDiterima': ''
    };
  }

  // Initial data
  List<Map<String, String>> data = [
    createDataRow(),
  ];

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
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.05),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 50,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20.0,
                  horizontalMargin: 20.0,
                  columns: [
                    DataColumn(
                      label: Center(
                        child: Text(
                          'No',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Kode Material',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Deskripsi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Satuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'QYT',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'QYT\nDiterima',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('1'),
                          ),
                        ),
                      ),
                      DataCell(
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('1'),
                          ),
                        ),
                      ),
                      DataCell(
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('1'),
                          ),
                        ),
                      ),
                      DataCell(
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('1'),
                          ),
                        ),
                      ),
                      DataCell(
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('1'),
                          ),
                        ),
                      ),
                      DataCell(
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('1'),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // Padding(
      //   padding: EdgeInsets.symmetric(
      //       vertical: screenHeight * 0.05, horizontal: screenWidth * 0.01),
      //   child: Column(
      //     children: [
      //       Text(
      //         'Checklist',
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //         textAlign: TextAlign.left,
      //       ),
      //       SizedBox(
      //         height: screenHeight * 0.01,
      //       ),
      //       Expanded(
      //         child: SingleChildScrollView(
      //           controller: _scrollController,
      //           scrollDirection: Axis.vertical,
      //           child: Table(
      //             border: TableBorder.all(
      //               color: Colors.black,
      //               width: 1.0,
      //               style: BorderStyle.solid,
      //             ),
      //             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      //             children: [
      //               TableRow(
      //                 children: [
      //                     TableCell(
      //                         child: Padding(
      //                       padding: EdgeInsets.all(screenWidth * 0.005),
      //                       child: Text(
      //                         'No',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(fontWeight: FontWeight.w600),
      //                       ),
      //                     )),
      //                     TableCell(
      //                         child: Padding(
      //                       padding: EdgeInsets.all(screenWidth * 0.005),
      //                       child: Text(
      //                         'Kode\nMaterial',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(fontWeight: FontWeight.w600),
      //                       ),
      //                     )),
      //                     TableCell(
      //                         child: Padding(
      //                       padding: EdgeInsets.all(screenWidth * 0.005),
      //                       child: Text(
      //                         'Deskripsi',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(fontWeight: FontWeight.w600),
      //                       ),
      //                     )),
      //                     TableCell(
      //                         child: Padding(
      //                       padding: EdgeInsets.all(screenWidth * 0.005),
      //                       child: Text(
      //                         'Satuan',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(fontWeight: FontWeight.w600),
      //                       ),
      //                     )),
      //                     TableCell(
      //                         child: Padding(
      //                       padding: EdgeInsets.all(screenWidth * 0.005),
      //                       child: Text(
      //                         'QYT',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(fontWeight: FontWeight.w600),
      //                       ),
      //                     )),
      //                     TableCell(
      //                         child: Padding(
      //                       padding: EdgeInsets.all(screenWidth * 0.005),
      //                       child: Text(
      //                         'QYT\nDiterima',
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(fontWeight: FontWeight.w600),
      //                       ),
      //                     )),
      //                   ]),
      //                   TableRow(children: [
      //                     TableCell(
      //                       child: Padding(
      //                         padding: EdgeInsets.all(screenWidth * 0.005),
      //                         child: TextField(
      //                           maxLines: 5,
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.symmetric(
      //                                 vertical: screenHeight * 0.01,
      //                                 horizontal: screenWidth * 0.01),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     TableCell(
      //                       child: Padding(
      //                         padding: EdgeInsets.all(screenWidth * 0.005),
      //                         child: TextField(
      //                           maxLines: 5,
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.symmetric(
      //                                 vertical: screenHeight * 0.01,
      //                                 horizontal: screenWidth * 0.01),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     TableCell(
      //                       child: Padding(
      //                         padding: EdgeInsets.all(screenWidth * 0.005),
      //                         child: TextField(
      //                           maxLines: 5,
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.symmetric(
      //                                 vertical: screenHeight * 0.01,
      //                                 horizontal: screenWidth * 0.01),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     TableCell(
      //                       child: Padding(
      //                         padding: EdgeInsets.all(screenWidth * 0.005),
      //                         child: TextField(
      //                           maxLines: 5,
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.symmetric(
      //                                 vertical: screenHeight * 0.01,
      //                                 horizontal: screenWidth * 0.01),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     TableCell(
      //                       child: Padding(
      //                         padding: EdgeInsets.all(screenWidth * 0.005),
      //                         child: TextField(
      //                           maxLines: 5,
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.symmetric(
      //                                 vertical: screenHeight * 0.01,
      //                                 horizontal: screenWidth * 0.01),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     TableCell(
      //                       child: Padding(
      //                         padding: EdgeInsets.all(screenWidth * 0.005),
      //                         child: TextField(
      //                           maxLines: 5,
      //                           decoration: InputDecoration(
      //                             border: InputBorder.none,
      //                             contentPadding: EdgeInsets.symmetric(
      //                                 vertical: screenHeight * 0.01,
      //                                 horizontal: screenWidth * 0.01),
      //                           ),
      //                         ),
      //                       ),
      //                     )
      //                   ]
      //                 )]
      //           ),
      //         ),
      //       ),

      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          size: 30,
          color: Color.fromRGBO(43, 56, 86, 1),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Color.fromRGBO(43, 56, 86, 1), width: 2),
        ),
        onPressed: () {
          for (var controllerList in controllers) {
            for (var controller in controllerList) {
              print(controller.text);
            }
          }

          setState(() {
            controllers.add([
              for (int k = 0; k < 6; k++) TextEditingController(),
            ]);
          });
        },
      ),
    );
  }
}
