import 'package:RekaChain/model/data_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  DataModel dataModel = DataModel(
      departemen: '',
      divisi: '',
      jabatan: '',
      kode_staff: '',
      nama: '',
      nip: '',
      nomorTelp: '',
      status: '',
      unit_kerja: '');
}
