class WisataModel{
   final String image;
  final String deskripsi;
  final String wisata;
  final String lokasi;
  final String source;

  WisataModel({
    required this.image,
    required this.deskripsi,
    required this.wisata,
    required this.lokasi,
    required this.source,
  });

  factory WisataModel.fromJson(Map<String, dynamic> json) {
    return WisataModel(
      image: json['image'],
      deskripsi: json['deskripsi'],
      wisata: json['wisata'],
      lokasi: json['lokasi'],
      source: json['source'],
    );
  }

}