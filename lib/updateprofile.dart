import 'dart:convert';
import 'dart:io';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/model/data_model.dart';
import 'package:RekaChain/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String nip;
  final DataModel data;
  const ProfilePage({Key? key, required this.nip, required this.data})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(data: data);
}

class _ProfilePageState extends State<ProfilePage> {
  late double screenWidth;
  late double screenHeight;

  final DataModel data;
  _ProfilePageState({required this.data});
  final formKey = GlobalKey<FormState>();
  TextEditingController kodestaffController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController unitKerjaController = TextEditingController();
  TextEditingController departemenController = TextEditingController();
  TextEditingController divisiController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    namaController = TextEditingController(text: widget.data.nama ?? '');
    jabatanController = TextEditingController(text: widget.data.jabatan ?? '');
    unitKerjaController =
        TextEditingController(text: widget.data.unit_kerja ?? '');
    nipController = TextEditingController(text: widget.data.nip ?? '');
    divisiController = TextEditingController(text: widget.data.divisi ?? '');
    statusController = TextEditingController(text: widget.data.status ?? '');
    departemenController =
        TextEditingController(text: widget.data.departemen ?? '');
    nomorTeleponController =
        TextEditingController(text: widget.data.nomorTelp ?? '');
    kodestaffController =
        TextEditingController(text: widget.data.kode_staff ?? '');
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.9.177/ProjectScanner/lib/API/updateprofile.php?nip=${widget.data.nip}&nama=${widget.data.nama}&unit_kerja=${widget.data.unit_kerja}'),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final nip = responseData['nip'];
        setState(() {
          kodestaffController.text = responseData['kode_staff'];
          nipController.text = responseData['nip'];
          namaController.text = responseData['nama'];
          jabatanController.text = responseData['jabatan'];
          unitKerjaController.text = responseData['unit_kerja'];
          departemenController.text = responseData['departemen'];
          divisiController.text = responseData['divisi'];
          nomorTeleponController.text = responseData['no_telp'];
          statusController.text = responseData['status'];
        });
      } else {
        print('Gagal mendapatkan data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  XFile? _selectedImage;

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
        buildTextField('Nama Lengkap', namaController),
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

  void _updateDataAndNavigateToProfile() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.9.177/ProjectScanner/lib/API/updateprofile.php'),
        body: {
          'kode_staff': kodestaffController.text,
          'nama': namaController.text,
          'jabatan': jabatanController.text,
          'unit_kerja': unitKerjaController.text,
          'departemen': departemenController.text,
          'divisi': divisiController.text,
          'no_telp': nomorTeleponController.text,
          'status': statusController.text,
          'nip': nipController.text,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileCard(
              data: DataModel(
                nama: namaController.text,
                jabatan: jabatanController.text,
                unit_kerja: unitKerjaController.text,
                departemen: departemenController.text,
                divisi: divisiController.text,
                nomorTelp: nomorTeleponController.text,
                nip: nipController.text,
                status: statusController.text,
                kode_staff: kodestaffController.text,
              ),
              nip: nipController.text,
            ),
          ),
        );
      } else {
        print('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _updateDataAndNavigateToProfile();
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: screenHeight * 0.01,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: Column(
          children: [
            _buildAvatar(),
            SizedBox(height: screenHeight * 0.1),
            _buildFormFields(),
            SizedBox(height: screenHeight * 0.03),
            _buildSubmitButton(),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
