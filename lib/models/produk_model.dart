class ProdukModel {
  final int idProduk;
  final int idUser;
  final String namaToko;
  final String namaProduk;
  final String image;
  final String rating;
  final int harga;

  ProdukModel({
    required this.idProduk,
    required this.idUser,
    required this.namaToko,
    required this.namaProduk,
    required this.image,
    required this.rating,
    required this.harga,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      idProduk: json['id_produk'],
      idUser: json['id_user'],
      namaToko: json['nama_user'],
      namaProduk: json['nama_produk'],
      image: json['foto_depan'],
      rating: json['rata_rating'],
      harga: json['harga_sewa'],
    );
  }
}