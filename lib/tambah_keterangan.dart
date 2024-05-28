import 'package:flutter/material.dart';
import 'package:RekaChain/keterangan.dart';

class TambahKeterangan extends StatelessWidget {
  const TambahKeterangan({super.key});

  void _saveData(BuildContext context) {
    print('Data saved!');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Keterangan()),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Update Keterangan'),
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
                  hintText: 'Isi Keterangan',
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
                    MaterialPageRoute(builder: (context) => Keterangan()),
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
