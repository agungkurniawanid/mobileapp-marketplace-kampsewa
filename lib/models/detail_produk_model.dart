class DetailProdukModel {
  int idProduk;
  String namaProduk;
  String deskripsiProduk;
  String fotoDepan;
  String fotoBelakang;
  String fotoKiri;
  String fotoKanan;
  int hargaSewa;
  String rating;
  int totalUlasan;
  int idUser;
  String fotoUser;
  String namaUser;

  DetailProdukModel({
    required this.idProduk,
    required this.namaProduk,
    required this.deskripsiProduk,
    required this.fotoDepan,
    required this.fotoBelakang,
    required this.fotoKiri,
    required this.fotoKanan,
    required this.hargaSewa,
    required this.rating,
    required this.totalUlasan,
    required this.idUser,
    required this.fotoUser,
    required this.namaUser,
  });

  factory DetailProdukModel.fromJson(Map<String, dynamic> json) {
    return DetailProdukModel(
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      fotoDepan: json['foto_depan'],
      fotoBelakang: json['foto_belakang'],
      fotoKiri: json['foto_kiri'],
      fotoKanan: json['foto_kanan'],
      hargaSewa: json['harga_sewa'],
      rating: json['rating'],
      totalUlasan: json['total_ulasan'],
      idUser: json['id_user'],
      fotoUser: json['foto_user'],
      namaUser: json['nama_user'],
    );
  }
}
