import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:intl/intl.dart';

class ListKekurangan extends StatefulWidget {
  const ListKekurangan({super.key});

  @override
  State<ListKekurangan> createState() => _ListKekuranganState();
}

class _ListKekuranganState extends State<ListKekurangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('List Kekurangan'),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 8, // Sesuaikan dengan jumlah item yang diinginkan
        itemBuilder: (context, index) {
          return Padding(
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
                    'Kekurangan ${index + 1}',
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
                builder: (context) => TambahKekurangan(),
              ),
            );
          }),
    );
  }
}

class TambahKekurangan extends StatefulWidget {
  const TambahKekurangan({super.key});

  @override
  State<TambahKekurangan> createState() => _TambahKekuranganState();
}

class _TambahKekuranganState extends State<TambahKekurangan> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Isi Data Kekurangan',
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                minLines: 4, // Mengatur jumlah baris minimum
                maxLines: null,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListKekurangan()),
                  );
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
    );
  }
}
