import 'dart:convert';
import 'package:RekaChain/model/data_model.dart';
import 'package:crypto/crypto.dart';
import 'package:RekaChain/profile.dart';
import 'package:RekaChain/updateprofile.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
  static int get loggedInUserNIP => _LoginPageState.loggedInUserNIP;
}

class _LoginPageState extends State<LoginPage> {
  static late int loggedInUserNIP;

  TextEditingController nip = TextEditingController();
  TextEditingController password = TextEditingController();
  late double screenWidth;
  late double screenHeight;
  double hintTextSize = 15;

  @override
  void initState() {
    super.initState();
    nip = TextEditingController();
    password = TextEditingController();
  }

  String hashPassword(String password) {
    var bytes =
        utf8.encode(password); // Mengonversi string password ke bytes UTF-8
    var digest =
        sha1.convert(bytes); // Menghitung hash SHA-1 dari bytes password
    return digest.toString(); // Mengembalikan hash sebagai string
  }

  Future loginbtn() async {
    final hashedPassword = hashPassword(password.text);
    var response = await http.post(
        Uri.parse('http://192.168.9.177/ProjectScanner/lib/API/login.php'),
        body: {"nip": nip.text, "password": password.text});
    var jsonData = jsonDecode(response.body);
    dynamic data = (jsonData as Map<String, dynamic>);
    DataModel dataKaryawan = DataModel.getDataFromJSOn(data['data']);
    if (data['message'] == "Success") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileCard(
                    data: dataKaryawan,
                    nip: nip.text,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('username atau password salah'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: _page(),
      ),
    );
  }

  Widget _page() {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.040,
              left: screenWidth * 0.89,
              right: 0,
            ),
            child: Image(
              image: AssetImage('assets/images/bolder31.png'),
              width: screenWidth * 0.70, // Adjust the width as needed
              height: screenHeight * 0.10, // Adjust the height as needed
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.15),
                Image.asset(
                  'assets/images/logoREKA.png',
                  width: screenWidth * 0.5,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "REKA CHAIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "PT. REKAINDO GLOBAL JASA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                Text(
                  "NIP :",
                  style: TextStyle(fontSize: screenHeight * 0.023),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: screenHeight * 0.005),
                _inputField("NIP", nip, backgroundColor: Colors.white),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Password :",
                  style: TextStyle(fontSize: screenHeight * 0.023),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: screenHeight * 0.005),
                _inputField("Password", password,
                    isPassword: true, backgroundColor: Colors.white),
                SizedBox(height: screenHeight * 0.025),
                _loginButton(),
                Expanded(child: Container())
              ],
            ),
          ),
          // Positioned(
          //   bottom: -screenHeight * 0.001,
          //   left: 0,
          //   child: Image(
          //     image: AssetImage('assets/images/Bolder21.png'),
          //     width: screenWidth * 0.35,
          //     height: screenHeight * 0.11,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: screenWidth * 0.65,
      height: screenHeight * 0.04,
      child: Center(
        child: TextField(
          style: const TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 73, 72, 72),
              fontSize: hintTextSize * screenHeight / 700,
            ),
            fillColor: backgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          obscureText: isPassword,
        ),
      ),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        loginbtn();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: SizedBox(
        width: screenWidth * 0.5,
        height: screenHeight * 0.05,
        child: Center(
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenHeight * 0.021,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
