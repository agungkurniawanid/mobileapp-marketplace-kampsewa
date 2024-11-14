class AlamatTokoCheckoutModel {
  int idAlamat;
  String longitude;
  String latitude;
  String type;
  String detailLainnya;
  String userName;
  String address;

  AlamatTokoCheckoutModel({
    required this.idAlamat,
    required this.longitude,
    required this.latitude,
    required this.type,
    required this.detailLainnya,
    required this.userName,
    required this.address,
  });

  factory AlamatTokoCheckoutModel.fromJson(Map<String, dynamic> json) {
    return AlamatTokoCheckoutModel(
      idAlamat: json['id_alamat'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      type: json['type'],
      detailLainnya: json['detail_lainnya'],
      userName: json['user_name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_alamat': idAlamat,
      'longitude': longitude,
      'latitude': latitude,
      'type': type,
      'detail_lainnya': detailLainnya,
      'user_name': userName,
      'address': address,
    };
  }
}