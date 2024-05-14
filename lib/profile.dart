import 'dart:convert';

import 'package:RekaChain/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/updateprofile.dart';
import 'package:RekaChain/login.dart';
import 'package:http/http.dart' as http;

class User {
  final String kode_staff;
  final String nama;
  final String jabatan;
  final String unit_kerja;
  final String departemen;
  final String divisi;
  final String email;
  final String no_telp;
  final String nip;
  final String status;
  final String password;
  final String konfirmasi_password;

  User({
    required this.kode_staff,
    required this.nama,
    required this.jabatan,
    required this.unit_kerja,
    required this.departemen,
    required this.divisi,
    required this.email,
    required this.no_telp,
    required this.nip,
    required this.status,
    required this.password,
    required this.konfirmasi_password,
  });
}

class ProfileCard extends StatefulWidget {
  final DataModel data;
  final String nip;
  const ProfileCard({super.key, required this.nip, required this.data});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? _userData;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  TextEditingController namaController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController unitKerjaController = TextEditingController();

  List _listdata = [];
  bool _isLoading = true;
  String _errorMessage = 'Terjadi kesalahan saat mengambil data';

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.9.177/ProjectScanner/lib/tbl_tambahstaff/profileREAD.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Filter data berdasarkan NIP yang telah diperoleh sebelumnya
        Map<String, dynamic>? userData;
        for (var userDataItem in data) {
          if (userDataItem['nip'] == widget.nip) {
            userData = userDataItem;
            break;
          }
        }

        if (userData != null) {
          // Setel state untuk menampilkan data pengguna yang sesuai
          setState(() {
            _userData = userData;
            _isLoading = false;
          });
        } else {
          // Tampilkan pesan jika data pengguna tidak ditemukan
          setState(() {
            _isLoading = false;
            _errorMessage = 'Data pengguna tidak ditemukan';
          });
        }
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi
      print(e);
      setState(() {
        _isLoading = false;
        _errorMessage = 'Terjadi kesalahan saat mengambil data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _listdata.add(widget.data);
      updateData();
    }
    _getData();
  }

  Future<void> updateData() async {
    await _getData();
    setState(() {});
  }

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
            padding: EdgeInsets.only(
              top: screenHeight * 0.01,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hallo!',
                  style: TextStyle(
                    color: Color.fromRGBO(43, 56, 86, 1),
                    fontFamily: 'Donegal One',
                    fontSize: screenWidth * 0.075,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start, // Align text to the left
                ),

                _buildAvatar(),
                SizedBox(height: screenHeight * 0.05),
                _buildTextView('Nama',
                    text: _userData != null
                        ? _userData!['nama'].toString()
                        : widget.data.nama),
                _buildDivider(),
                _buildTextView('NIP',
                    text: _userData != null
                        ? _userData!['nip'].toString()
                        : widget.data.nip),
                _buildDivider(),
                _buildTextView('Unit Kerja',
                    text: _userData != null
                        ? _userData!['unit_kerja'].toString()
                        : widget.data.unit_kerja),

                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          data: widget.data,
                          nip: '',
                        ),
                      ),
                    ).then((result) {
                      if (result != null && result) {
                        updateData();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.015,
                      bottom: screenHeight * 0.015,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                    ),
                  ),
                  child: const Text('Ubah Profile'),
                ),
                // Spacer
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
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.015,
                      bottom: screenHeight * 0.015,
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                    ),
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
          width: screenWidth * 0.35,
          height: screenWidth * 0.35,
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
