import 'package:flutter/material.dart';
import 'dart:ui';

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
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 20),
            Text(
              "LOGIN",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Container(
                width: 300,
                decoration: BoxDecoration(color: Color.fromRGBO(96, 13, 33, 1)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _inputField("NIP", NIPController),
                    const SizedBox(height: 20),
                    _inputField("Password", passwordController,
                        isPassword: true),
                    const SizedBox(height: 20),
                  ],
                )),
            const SizedBox(height: 50),
            _loginBtn(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      child: Image.asset('assets/images/PT-Rekaindo-Global-Jasa 1.png'),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    // var border = OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(20),
    //     borderSide: const BorderSide(color: Colors.white));

    return SizedBox(
      width: 200,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(20),
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {},
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.white,
          onPrimary: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16)),
    );
  }
}
