import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController unitKerjaController = TextEditingController();
  TextEditingController departemenController = TextEditingController();
  TextEditingController divisiController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 5),
            Text('Ubah Profil'),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.camera_alt,
                  size: 16,
                ),
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'), // Ganti dengan path gambar profil Anda
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Align(
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('Nama Lengkap', namaLengkapController),
              buildDivider(),
              buildTextField('Jabatan', jabatanController),
              buildDivider(),
              buildTextField('Unit Kerja', unitKerjaController),
              buildDivider(),
              buildTextField('Departemen', departemenController),
              buildDivider(),
              buildTextField('Divisi', divisiController),
              buildDivider(),
              buildTextField('Nomor Telepon', nomorTeleponController),
              buildDivider(),
              buildTextField('NIP', nipController),
              buildDivider(),
              buildTextField('Password', passwordController, obscureText: true),
              buildDivider(),
              buildTextField('Status', statusController),
              buildDivider(),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi yang ingin Anda lakukan saat tombol "Selesai" ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(43, 56, 86, 1),
                    ),
                    child: Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Divider(
      color: Colors.grey,
      height: 8,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }
}
