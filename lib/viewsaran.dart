import 'dart:convert';
import 'package:RekaChain/tambahsaran.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListSaran extends StatefulWidget {
  const ListSaran({super.key});

  @override
  State<ListSaran> createState() => _ListSaranState();
}

class _ListSaranState extends State<ListSaran> {
  List<dynamic> saranList = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.8.107/ProjectScanner/lib/API/read_saran.php'),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          saranList = responseData;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('List Saran/Tindak lanjut'),
            const SizedBox(width: 10.0),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: AspectRatio(
                  aspectRatio: 11 / 8,
                  child: Image.asset(
                    'assets/images/bolder31.png',
                    width: 170,
                    height: 120,
                    fit: BoxFit.contain,
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
      body: saranList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: saranList.length,
              itemBuilder: (context, index) {
                final saran = saranList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewSaran(selectedProject: saran),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
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
                            'Saran/Tindak Lanjut ${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            saran['waktu'],
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
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahSaran(),
            ),
          );
        },
      ),
    );
  }
}

class ViewSaran extends StatelessWidget {
  final Map<String, dynamic> selectedProject;

  const ViewSaran({super.key, required this.selectedProject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Produk: ${selectedProject['kode_produk']}'),
            SizedBox(height: 10),
            Text('Saran: ${selectedProject['saran']}'),
            SizedBox(height: 10),
            Text('Waktu: ${selectedProject['waktu']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const SizedBox(
                width: 150,
                height: 40,
                child: Center(
                  child: Text(
                    "Kembali ke Daftar",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
