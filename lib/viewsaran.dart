import 'package:flutter/material.dart';

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
            Text('Saran: ${selectedProject['saran']}'),
            SizedBox(height: 10),
            Text('Waktu_saran: ${selectedProject['waktu_saran']}'),
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
