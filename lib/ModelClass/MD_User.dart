class User {
  final int kode_staff;
  final int nip;
  final int no_telp;
  final String nama;
  final String jabatan;
  final String unit_kerja;
  final String departemen;
  final String divisi;
  final String status;
  final String password;

  User(
      {required this.kode_staff,
      required this.nip,
      required this.no_telp,
      required this.nama,
      required this.jabatan,
      required this.unit_kerja,
      required this.departemen,
      required this.divisi,
      required this.status,
      required this.password});

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
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        kode_staff: json['kode_staff'],
        nip: json['nip'],
        no_telp: json['no_telp'],
        nama: json['nama'],
        jabatan: json['jabatan'],
        unit_kerja: json['unit_kerja'],
        departemen: json['departemen'],
        divisi: json['divisi'],
        status: json['status'],
        password: json['password']);
  }
}
