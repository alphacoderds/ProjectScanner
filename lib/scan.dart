import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: scan(),
    );
  }
}

class scan extends StatelessWidget {
  const scan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
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
        alignment: const Alignment(0, -0.5), // Mengatur posisi tombol ke atas
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
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Column(
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
            const SizedBox(
                height: 20), // Jarak antara tombol "Scan" dan tombol "Process"
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol "Process" ditekan
                print('Processing...');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16), backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), // Warna putih untuk tombol "Process"
              ),
              child: const Text('Process'),
            ),
            const SizedBox(
                height:
                    20), // Jarak antara tombol "Process" dan pemenuhan kekurangan
            ElevatedButton(
              onPressed: () {
                // Aksi yang ingin Anda lakukan saat tombol pemenuhan kekurangan ditekan
                print('Pemenuhan Kekurangan...');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Pemenuhan Kekurangan'),
            ),
          ],
        ),
      ),
    );
  }
}
