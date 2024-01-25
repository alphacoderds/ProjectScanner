import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_back, // Icon panah ke kiri
              color: Color.fromARGB(255, 10, 10, 10),
            ),
            SizedBox(width: 8), // Jarak antara icon dan teks
            Text('Reka Chain'),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment(0, -0.5), // Mengatur posisi tombol ke atas
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol "Scan" ditekan
                print('Melakukan scanning...');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.center_focus_weak,
                    size: 180,
                  ),
                  SizedBox(height: 20), // Jarak antara ikon dan teks
                  Text('Scan'),
                ],
              ),
            ),
            SizedBox(
                height: 20), // Jarak antara tombol "Scan" dan tombol "Process"
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol "Process" ditekan
                print('Processing...');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                primary: Colors.white, // Warna putih untuk tombol "Process"
              ),
              child: Text('Process'),
            ),
            SizedBox(
                height:
                    20), // Jarak antara tombol "Process" dan pemenuhan kekurangan
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol pemenuhan kekurangan ditekan
                print('Pemenuhan Kekurangan...');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Pemenuhan Kekurangan'),
            ),
          ],
        ),
      ),
    );
  }
}
