import 'package:flutter/material.dart';
import 'package:flutter_scanner/bottomnavbar.dart';
import 'package:flutter_scanner/updateprofile.dart';
import 'package:flutter_scanner/login.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
            );
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Hallo!',
                  style: TextStyle(
                    color: Color.fromRGBO(43, 56, 86, 1),
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start, // Align text to the left
                ),

                _buildAvatar(),
                const SizedBox(height: 16.0),
                _buildTextView('Nama',
                    text: 'John Doe'), // Set the text accordingly
                _buildDivider(),
                _buildTextView('NIP',
                    text: '123456789'), // Set the text accordingly
                _buildDivider(),
                _buildTextView('Unit Kerja',
                    text: 'Sample Unit'), // Set the text accordingly
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                  ),
                  child: const Text('Ubah Profile'),
                ),
                const SizedBox(height: 16.0), // Spacer
                ElevatedButton(
                  onPressed: () {
                    _showLogoutConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHelloText() {
    return const Text(
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
            image: const DecorationImage(
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
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1.0,
      height: 16.0,
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Logika logout
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const loginpage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
