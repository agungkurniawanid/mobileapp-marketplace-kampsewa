class RiwayatModel {
  final int id;
  final String namaToko;
  final String namaProduk;
  final String qty;
  final String warna;
  final String ukuran;
  final String qtyProdukLain;
  final String rating;
  final String harga;
  final String totalPesanan;
  final String hari;
  final String fotoProduk;
  final String statusTransaksi;

  const RiwayatModel({
    required this.id,
    required this.namaToko,
    required this.namaProduk,
    required this.fotoProduk,
    required this.qty,
    required this.warna,
    required this.ukuran,
    required this.qtyProdukLain,
    required this.rating,
    required this.harga,
    required this.totalPesanan,
    required this.hari,
    required this.statusTransaksi,
  });

  factory RiwayatModel.fromJson(Map<String, dynamic> json) {
    return RiwayatModel(
      id: json['id'],
      namaToko: json['nama_toko'],
      namaProduk: json['nama_produk'],
      fotoProduk: json['foto_produk'],
      qty: json['qty'],
      warna: json['warna'],
      ukuran: json['ukuran'],
      qtyProdukLain: json['qty_produk_lain'],
      rating: json['rating'],
      harga: json['harga'],
      totalPesanan: json['total_pesanan'],
      hari: json['durasi'],
      statusTransaksi: json['status_transaksi'],
    );
  }
}
