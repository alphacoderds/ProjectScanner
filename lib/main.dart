import 'package:flutter/material.dart';
import 'package:flutter_scanner/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: loginpage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('REKA Chain Login'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'NIP',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your NIP';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'REKA',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your REKA';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 return null;
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                 // TODO: Implement login logic here.
//                 }
//               },
//             child: Text('Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }