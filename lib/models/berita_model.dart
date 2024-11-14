class BeritaModel {
  final int id;
  final String judul;
  final String image;
  final String source;
  final String link;

  BeritaModel({
    required this.id,
    required this.judul,
    required this.image,
    required this.source,
    required this.link,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      id: json['id'],
      judul: json['judul'],
      image: json['image'],
      source: json['source'],
      link: json['link'],
    );
  }
}
