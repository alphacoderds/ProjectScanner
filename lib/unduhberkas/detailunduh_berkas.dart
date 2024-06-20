import 'package:flutter/material.dart';

class DetailUnduh extends StatelessWidget {
  final Map<String, dynamic> detailunduh;

  DetailUnduh({required this.detailunduh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berkas'),
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
              onTap: () {},
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
                ),
                // Add more details here as required, for example:
                Text(
                  'Detail: ${detailunduh['someDetail'] ?? 'Tidak Ada Detail'}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class detailunduh extends StatelessWidget {
//   final Map<String, dynamic> detailunduh;

//   detailunduh({required this.detailunduh});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detail Berkas'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 0.0),
//             child: GestureDetector(
//               onTap: () {},
//               child: Image.asset(
//                 'assets/images/bolder32.png',
//                 width: 60,
//                 height: 60,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.transparent],
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 20),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
