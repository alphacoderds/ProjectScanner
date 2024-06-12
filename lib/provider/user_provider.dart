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
      no_telp: '',
      status: '',
      unit_kerja: '');

  DataModel get userData => dataModel;

  void setUserData(DataModel userData) {
    dataModel = userData;
    notifyListeners();
  }

  DataModel? getUserDataByNip(String nip) {
    if (dataModel.nip == nip) {
      return dataModel;
    }
    return null;
  }
}
