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
<<<<<<< HEAD
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
=======
                Expanded(
                  child:
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
>>>>>>> 22370ea6fc2ce9a066b6b4e83eae8b519ce004ef
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
