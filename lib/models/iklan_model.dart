class IklanModel {
  int id;
  String poster;
  String judul;

  IklanModel({required this.id, required this.poster, required this.judul});

  factory IklanModel.fromJson(Map<String, dynamic> json) {
    return IklanModel(
      id: json['id'],
      poster: json['poster'],
      judul: json['judul'],
    );
  }
}
