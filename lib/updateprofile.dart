import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
        title: const Row(
          children: [
            SizedBox(width: 5),
            Text('Ubah Profil'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'),
                child: Icon(
                  Icons.camera_alt,
                  size: 16,
                ), // Ganti dengan path gambar profil Anda
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(top: 5),
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
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi yang ingin Anda lakukan saat tombol "Selesai" ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(43, 56, 86, 1),
                    ),
                    child: const Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            fontSize: 16,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: Colors.grey,
      height: 8,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }
}
