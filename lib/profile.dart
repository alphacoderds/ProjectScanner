import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/updateprofile.dart';

class ProfileCard extends StatefulWidget {
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hallo!',
                style: TextStyle(
                  color: Color.fromRGBO(43, 56, 86, 1),
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start, // Align text to the left
              ),

              _buildAvatar(),
              SizedBox(height: 16.0),
              _buildTextView('Nama',
                  text: 'John Doe'), // Set the text accordingly
              _buildDivider(),
              _buildTextView('NIP',
                  text: '123456789'), // Set the text accordingly
              _buildDivider(),
              _buildTextView('Unit Kerja',
                  text: 'Sample Unit'), // Set the text accordingly
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(43, 56, 86, 1),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                ),
                child: Text('Ubah Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelloText() {
    return Text(
      'Hallo!',
      style: TextStyle(
        color: Color.fromRGBO(43, 56, 86, 1),
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: NetworkImage('assets/images/profile-illustration.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextView(String label, {required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 16.0,
    );
  }
}
