import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';

class AfterSalesData extends StatefulWidget {
  const AfterSalesData({super.key});

  @override
  State<AfterSalesData> createState() => _AfterSalesDataState();
}

class _AfterSalesDataState extends State<AfterSalesData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Data Pelanggan'),
              const SizedBox(width: 10.0),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FractionalTranslation(
                    translation: const Offset(0.37, 0.10),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 180,
                  height: 70,
                  child: Center(
                    child: Text(
                      "List Kerusakan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  primary: Color.fromRGBO(43, 56, 86, 1),
                  onPrimary: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 180,
                  height: 70,
                  child: Center(
                    child: Text(
                      "Saran / Tindak Lanjut",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  primary: Color.fromRGBO(43, 56, 86, 1),
                  onPrimary: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
