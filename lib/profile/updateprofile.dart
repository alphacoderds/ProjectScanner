import 'dart:convert';
import 'dart:io';
import 'package:RekaChain/bottomnavbar.dart';
import 'package:RekaChain/model/data_model.dart';
import 'package:RekaChain/profile/profile.dart';
import 'package:RekaChain/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double screenWidth;
  late double screenHeight;
  final formKey = GlobalKey<FormState>();

  TextEditingController kodestaffController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  TextEditingController unitKerjaController = TextEditingController();
  TextEditingController departemenController = TextEditingController();
  TextEditingController divisiController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    fetchData();
    _getdata();
  }

  Future<void> fetchData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final int nip = userProvider.dataModel.nip;
    if (nip != null) {
      DataModel? data = userProvider.dataModel;
      if (data != null) {
        setState(() {
          kodestaffController.text = data.kode_staff;
          nipController.text = data.nip.toString();
          namaController.text = data.nama;
          jabatanController.text = data.jabatan;
          unitKerjaController.text = data.unit_kerja;
          departemenController.text = data.departemen;
          divisiController.text = data.divisi;
          nomorTeleponController.text = data.no_telp;
          statusController.text = data.status;
        });
      }
    }
  }

  Future _getdata() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final response = await http.post(
          body: {"nip": userProvider.dataModel.nip.toString()},
          Uri.parse(
              'http://10.208.204.53/ProjectScanner/lib/Profile/profileREAD.php'));
      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          context
              .read<UserProvider>()
              .setUserData(DataModel.getDataFromJSOn(data));
          setState(() {
            namaController.text = data['nama'] ?? '';
            jabatanController.text = data['jabatan'] ?? '';
            unitKerjaController.text = data['unit_kerja'] ?? '';
            departemenController.text = data['departemen'] ?? '';
            divisiController.text = data['divisi'] ?? '';
            nomorTeleponController.text = data['no_telp'] ?? '';
            nipController.text = data['nip'] ?? '';
            statusController.text = data['status'] ?? '';
          });
        } catch (e) {
          print('Error parsing JSON: $e');
          print('Response body: ${response.body}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
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

  void _updateDataAndNavigateToProfile() async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://10.208.204.53/ProjectScanner/lib/Profile/updateprofile.php'));

      request.fields['kode_staff'] = kodestaffController.text;
      request.fields['nama'] = namaController.text;
      request.fields['jabatan'] = jabatanController.text;
      request.fields['unit_kerja'] = unitKerjaController.text;
      request.fields['departemen'] = departemenController.text;
      request.fields['divisi'] = divisiController.text;
      request.fields['no_telp'] = nomorTeleponController.text;
      request.fields['status'] = statusController.text;
      request.fields['nip'] = nipController.text;

      if (_selectedImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('profile', _selectedImage!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Update successful: $responseBody');

        var decodedResponse = jsonDecode(responseBody);
        if (decodedResponse['status'] == 'success') {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          final response = await http.post(
              body: {"nip": userProvider.dataModel.nip.toString()},
              Uri.parse(
                  'http://10.208.204.53/ProjectScanner/lib/Profile/profileREAD.php'));
          print(response.body);
          print(response.statusCode);
          if (response.statusCode == 200) {
            var finalData = jsonDecode(response.body);

            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider
                .setUserData(DataModel.getDataFromJSOn(finalData['data']));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProfileCard()));
          } else {
            print('Server error: ${decodedResponse['message']}');
          }
        } else {
          print('Server error: ${decodedResponse['message']}');
        }
      } else {
        print('Failed to update data: ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Consumer<UserProvider>(builder: (context, prov, child) {
          if (_selectedImage == null) {
            return Container(
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
                image: prov.dataModel.profile == ''
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: AssetImage('assets/images/default_image.png'),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: NetworkImage(prov.dataModel.profile),
                      ),
              ),
            );
          } else {
            return Container(
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
                image: prov.dataModel.profile != ''
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
            );
          }
        }),
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
                border: Border.all(width: 4, color: Colors.white),
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
        buildTextField('NIP', nipController,
            enabled: false), // NIP tidak bisa diedit
        buildDivider(),
        buildTextField('Status', statusController),
        buildDivider(),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16),
        ),
        TextFormField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(border: InputBorder.none),
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
          onPressed: _updateDataAndNavigateToProfile,
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
