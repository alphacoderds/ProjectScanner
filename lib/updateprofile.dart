import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildAvatar(),
      ),
    );
  }

  Widget _buildAvatar() {
    return Column(
      children: [
        Stack(
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
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                  color: const Color.fromARGB(255, 22, 44, 62),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 70),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Nama Lengkap', namaLengkapController),
            buildDivider(),
            buildTextField('Jabatan', jabatanController),
            buildDivider(),
            buildTextField('Unit Kerja', unitKerjaController),
            buildDivider(),
            buildTextField('Departement', departemenController),
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
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets\images\profile-illustration.png"),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
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
