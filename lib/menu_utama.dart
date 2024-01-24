import 'package:flutter/material.dart';

class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("REKA CHAIN",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      "Selamat Datang...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Image.asset(
                  'assets/images/bolder32.png',
                  width: 200,
                  alignment: Alignment.topRight,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
