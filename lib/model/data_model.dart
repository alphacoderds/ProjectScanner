class DataModel {
  String kode_staff;
  String nama;
  String jabatan;
  String unit_kerja;
  String departemen;
  String divisi;
  String nomorTelp;
  String nip;
  String status;

  DataModel(
      {required this.departemen,
      required this.divisi,
      required this.jabatan,
      required this.kode_staff,
      required this.nama,
      required this.nip,
      required this.nomorTelp,
      required this.status,
      required this.unit_kerja});

  Map<String, dynamic> toJson() {
    return {
      'kode_staff': kode_staff,
      'nip': nip,
      'no_telp': nomorTelp,
      'nama': nama,
      'jabatan': jabatan,
      'unit_kerja': unit_kerja,
      'departemen': departemen,
      'divisi': divisi,
      'status': status,
    };
  }

  factory DataModel.getDataFromJSOn(Map<String, dynamic> json) {
    return DataModel(
        departemen: json['departemen'],
        divisi: json['divisi'],
        jabatan: json['jabatan'],
        kode_staff: json['kode_staff'],
        nama: json['nama'],
        nip: json['nip'],
        nomorTelp: json['no_telp'],
        status: json['status'],
        unit_kerja: json['unit_kerja']);
  }
}
