import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController NIPController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 345,
            right: 0,
            child: Image(
              image: AssetImage('assets/images/bolder31.png'),
              width: 150,
              height: 100,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/logoREKA.png',
                  width: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  "REKA CHAIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "PT. REKAINDO GLOBAL JASA",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Text("Username :",
                    style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                const SizedBox(height: 5),
                _inputField("Username", NIPController,
                    backgroundColor: Colors.white),
                const SizedBox(height: 10),
                Text("Password :",
                    style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                const SizedBox(height: 5),
                _inputField("Password", passwordController,
                    isPassword: true, backgroundColor: Colors.white),
                const SizedBox(height: 50),
                _loginBtn(),
                Expanded(child: Container())
              ],
            ),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            child: Image(
              image: AssetImage('assets/images/Bolder21.png'),
              width: 150,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hintText, controller,
      {bool isPassword = false, Color? backgroundColor}) {
    return SizedBox(
      width: 270,
      height: 40,
      child: Center(
        child: TextField(
          style: const TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 73, 72, 72),
              fontSize: 15,
            ),
            fillColor: backgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          obscureText: isPassword,
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
        onPressed: () {},
        child: const SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          primary: Color.fromRGBO(43, 56, 86, 1),
          onPrimary: Colors.white,
        ));
  }
}
