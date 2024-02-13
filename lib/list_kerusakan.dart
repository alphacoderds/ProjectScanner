import 'package:flutter/material.dart';
import 'package:RekaChain/aftersales.dart';
import 'package:intl/intl.dart';

class ListKerusakan extends StatefulWidget {
  const ListKerusakan({super.key});

  @override
  State<ListKerusakan> createState() => _ListKerusakanState();
}

class _ListKerusakanState extends State<ListKerusakan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('List Kerusakan'),
            SizedBox(width: 10.0),
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AfterSalesData()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TambahKerusakan()),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xBF2B3856),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kerusakan ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add_rounded,
            size: 40,
            weight: 60,
          ),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahKerusakan(),
              ),
            );
          }),
    );
  }
}

class TambahKerusakan extends StatefulWidget {
  const TambahKerusakan({super.key});

  @override
  State<TambahKerusakan> createState() => _TambahKerusakanState();
}

class _TambahKerusakanState extends State<TambahKerusakan> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  bool _lastRowFilled = true;

  // Data structure for each row
  static Map<String, String> createDataRow() {
    return {'no': '', 'detailKerusakan': '', 'item': '', 'keterangan': ''};
  }

  // Initial data
  List<Map<String, String>> data = [
    createDataRow(),
  ];

  TextEditingController KekuranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Data Konsumen'),
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.08),
                Text(
                  "Isi Data Kerusakan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.05),
                DataTable(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        "No",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Detail\nKerusakan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Item",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Keterangan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  rows: data.map((item) {
                    return DataRow(
                      cells: [
                        DataCell(SizedBox(
                          height: screenHeight * 0.9,
                          child: TextField(
                            controller: TextEditingController(text: item['no']),
                            maxLines: 5,
                            onChanged: (value) => item['no'] = value,
                          ),
                        )),
                        DataCell(SizedBox(
                          height: screenHeight * 0.9,
                          child: TextField(
                            controller: TextEditingController(
                              text: item['detailKerusakan'],
                            ),
                            maxLines: 5,
                            onChanged: (value) =>
                                item['detailKerusakan'] = value,
                          ),
                        )),
                        DataCell(SizedBox(
                          height: screenHeight * 0.9,
                          child: TextField(
                            controller:
                                TextEditingController(text: item['item']),
                            maxLines: 5,
                            onChanged: (value) => item['item'] = value,
                          ),
                        )),
                        DataCell(IntrinsicHeight(
                          child: TextField(
                            controller:
                                TextEditingController(text: item['keterangan']),
                            maxLines: 5,
                            onChanged: (value) => item['keterangan'] = value,
                          ),
                        )),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                    onPressed: () {
                      _saveData();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ListKerusakan()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                          child: Text(
                            "Simpan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveData() {
    if (_lastRowFilled) {
      // Validasi input (opsional)
      data.add(createDataRow());
      _lastRowFilled = false; // Baris baru akan dianggap kosong
      setState(() {});
      // Opsional, simpan data di database atau penyimpanan lainnya
    } else {
      // Tampilkan pesan peringatan atau pemberitahuan bahwa baris sebelumnya masih kosong
    }
  }
}
