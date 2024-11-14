class AlamatUserModel {
  int id;
  int idUser;
  String longitude;
  String latitude;
  String? detailLainnya;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String nomorTelephone;

  AlamatUserModel({
    required this.id,
    required this.idUser,
    required this.longitude,
    required this.latitude,
    this.detailLainnya,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.nomorTelephone,
  });

  factory AlamatUserModel.fromJson(Map<String, dynamic> json) {
    return AlamatUserModel(
      id: json['id'],
      idUser: json['id_user'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      detailLainnya: json['detail_lainnya'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      name: json['name'],
      nomorTelephone: json['nomor_telephone'],
    );
  }
}
