class OpenItemModel {
  String no;
  String isi;

  OpenItemModel({required this.isi, required this.no});

  factory OpenItemModel.getItemFromJSON(Map<String, dynamic> json) {
    return OpenItemModel(isi: json['isi'], no: json['no']);
  }
}