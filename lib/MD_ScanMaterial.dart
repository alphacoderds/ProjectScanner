class ScanMaterial {
  final int no;
  final String kodeMaterial;
  final String deskripsi;
  final String satuan;
  final int qty;
  final int qtyDiterima;

  ScanMaterial({
    required this.no,
    required this.kodeMaterial,
    required this.deskripsi,
    required this.satuan,
    required this.qty,
    required this.qtyDiterima,
  });

  factory ScanMaterial.fromJson(Map<String, dynamic> json) {
    return ScanMaterial(
      no: json['no'],
      kodeMaterial: json['kode_material'],
      deskripsi: json['deskripsi'],
      satuan: json['satuan'],
      qty: json['qty'],
      qtyDiterima: json['qty_diterima'],
    );
  }
}
