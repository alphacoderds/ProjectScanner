class DataModel {
  String kode_staff;
  String nama;
  String jabatan;
  String unit_kerja;
  String departemen;
  String divisi;
  String no_telp;
  String profile;
  int nip;
  String status;

  DataModel(
      {required this.departemen,
      required this.divisi,
      required this.jabatan,
      required this.kode_staff,
      required this.nama,
      required this.nip,
      required this.profile,
      required this.no_telp,
      required this.status,
      required this.unit_kerja});

  Map<String, dynamic> toJson() {
    return {
      'kode_staff': kode_staff,
      'nip': nip,
      'no_telp': no_telp,
      'nama': nama,
      'jabatan': jabatan,
      'unit_kerja': unit_kerja,
      'departemen': departemen,
      'divisi': divisi,
      'status': status,
      'profile': profile
    };
  }

  factory DataModel.getDataFromJSOn(Map<String, dynamic> json) {
    return DataModel(
        departemen: json['departemen'],
        divisi: json['divisi'],
        jabatan: json['jabatan'],
        kode_staff: json['kode_staff'],
        nama: json['nama'],
        nip: int.parse(json['nip']) ,
        no_telp: json['no_telp'],
        status: json['status'],
        profile: json['profile'],
        unit_kerja: json['unit_kerja']);
  }
}
