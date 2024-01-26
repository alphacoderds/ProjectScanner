import 'package:flutter/material.dart';
import 'package:flutter_scanner/keterangan.dart';

class TambahKeterangan extends StatelessWidget {
  // Function to handle save button press
  void _saveData(BuildContext context) {
    // Implement your save logic here
    // This function will be called when the save button is pressed
    print('Data saved!');

    // Navigasi kembali ke halaman Keterangan.dart
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Keterangan()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keterangan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GestureDetector(
              onTap: () {
                _saveData(context); // Panggil fungsi save saat ikon ditekan
              },
              child: Image.asset(
                'assets/images/bolder32.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent],
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // Remove the additional AppBar here
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Your content goes here', // Tambahkan konten Anda di sini
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                _saveData(context); // Panggil fungsi save saat tombol ditekan
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
