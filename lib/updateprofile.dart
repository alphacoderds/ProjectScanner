import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_scanner/profile.dart';
import 'package:image_picker/image_picker.dart';

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

  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAvatar(),
            const SizedBox(height: 70),
            _buildFormFields(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
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
            image: _selectedImage != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    image: FileImage(File(_selectedImage!.path)),
                  )
                : const DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    image: AssetImage('assets/images/default_image.png'),
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              _pickImage();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Colors.white,
                ),
                color: const Color.fromARGB(255, 17, 46, 70),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
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
      ],
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

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileCard(),
              ),
            );
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

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    setState(() {
                      _selectedImage = image;
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);

                  if (image != null) {
                    setState(() {
                      _selectedImage = image;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
