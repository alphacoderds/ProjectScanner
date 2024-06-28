import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:universal_html/html.dart' as html show Blob, Url, AnchorElement;
import 'dart:typed_data';

class Unduh extends StatefulWidget {
  final Map<String, dynamic>? newProject;
  final String id_lot;

  const Unduh({Key? key, this.newProject, required this.id_lot})
      : super(key: key);

  @override
  _UnduhState createState() => _UnduhState();
}

class _UnduhState extends State<Unduh> {
  late double _screenWidth;
  late double _screenHeight;
  List<Map<String, dynamic>> _unduh = [];

  late final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.8.26/ProjectScanner/lib/unduhberkas/get_unduh.php?id_lot=${widget.id_lot}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _unduh = data.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldMessengerKey,
      appBar: AppBar(
        title: Text('List Dokumen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _unduh.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _unduh.length,
              itemBuilder: (context, index) {
                return _buildDismissibleItem(_unduh[index], index);
              },
            ),
    );
  }

  Widget _buildDismissibleItem(Map<String, dynamic> unduhData, int index) {
    return Dismissible(
      key: Key(unduhData['noProduk'].toString()),
      direction: DismissDirection
          .endToStart, // Change to endToStart for swipe left to download
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(Icons.download, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Text("Konfirmasi"),
              ),
              content: Center(
                child: Text("Apakah Anda yakin ingin mengunduh file ini?"),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _downloadFileFromDatabase(
                        unduhData, unduhData['file'].split('/').last);
                  },
                  child: Text("Ya"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Tidak"),
                ),
              ],
            );
          },
        );
      },
      child: _buildUnduhCard(unduhData),
    );
  }

  Widget _buildUnduhCard(Map<String, dynamic> unduhData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        color: Color.fromARGB(255, 23, 46, 81),
        child: ListTile(
          title: Text(
            'Nomor Produk: ${unduhData['noProduk'] ?? 'Tidak Ada'}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'File: ${unduhData['file'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal: ${unduhData['tanggal'] ?? 'Tidak Ada'}',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          onTap: () {
            _downloadFileFromDatabase(
                unduhData, unduhData['file'].split('/').last);
          },
        ),
      ),
    );
  }

  Future<void> _downloadFileFromDatabase(
      Map<String, dynamic> data, String fileName) async {
    if (data['file'] != null) {
      String fileRelativePath = data['file'];

      try {
        String fileUrl =
            'http://192.168.8.26/ProjectWebAdminRekaChain/lib/Project/uploads/$fileRelativePath';

        //You can download a single file
        await FileDownloader.downloadFile(
            url:
                "https://file-examples.com/storage/fed5266c9966708dcaeaea6/2017/10/file-sample_150kB.pdf",
            name: fileName, //(optional)
            subPath: fileRelativePath, //(optional)
            onProgress: (fileName, progress) {
              print("progress");
            },
            onDownloadCompleted: (String path) {
              print('FILE DOWNLOADED TO PATH: $path');
            },
            onDownloadError: (String error) {
              print('DOWNLOAD ERROR: $error');
            });
      } catch (e) {
        print('Error downloading file: $e');
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void downloadFile(Uint8List fileBytes, String fileName) {
    final blob = html.Blob([fileBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
