class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? nomorTelephone;
  String? tanggalLahir;
  String? namaStore;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.nomorTelephone,
      this.namaStore,
      this.tanggalLahir});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
    id : json['id'],
    name : json['name'],
    email : json['email'],
    image : json['foto'],
    nomorTelephone : json['nomor_telephone'],
    tanggalLahir : json['tanggal_lahir'],
    namaStore : json['name_store']);
  }
}
