import 'package:flutter/material.dart';
import 'package:flutter_scanner/keterangan.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keterangan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GestureDetector(
              onTap: () {
                _saveData(context);
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent],
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Your content goes here',
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
                _saveData(context);
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
