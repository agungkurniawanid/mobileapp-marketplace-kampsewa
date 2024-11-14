class VariantProductModel {
  int idProduk;
  String namaProduk;
  String fotoDepan;
  int idVariantProduk;
  String warna;
  int idDetailVariantProduk;
  String ukuran;
  int stok;
  int hargaSewa;

  VariantProductModel({
    required this.idProduk,
    required this.namaProduk,
    required this.fotoDepan,
    required this.idVariantProduk,
    required this.warna,
    required this.idDetailVariantProduk,
    required this.ukuran,
    required this.stok,
    required this.hargaSewa,
  });

  factory VariantProductModel.fromJson(Map<String, dynamic> json) {
    return VariantProductModel(
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      fotoDepan: json['foto_depan'],
      idVariantProduk: json['id_variant_produk'],
      warna: json['warna'],
      idDetailVariantProduk: json['id_detail_variant_produk'],
      ukuran: json['ukuran'],
      stok: json['stok'],
      hargaSewa: json['harga_sewa'],
    );
  }
}