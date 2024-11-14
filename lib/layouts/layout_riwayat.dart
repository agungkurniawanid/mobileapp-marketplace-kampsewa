import 'package:flutter/material.dart';
import 'package:project_camp_sewa/components/card/riwayat_card.dart';
import 'package:project_camp_sewa/models/riwayat_model.dart';

class LayoutRiwayat extends StatefulWidget {
  final List<RiwayatModel> riwayatData;
  const LayoutRiwayat({super.key, required this.riwayatData});

  @override
  State<LayoutRiwayat> createState() => _LayoutRiwayatState();
}

class _LayoutRiwayatState extends State<LayoutRiwayat> {
  late List<RiwayatModel> listRiwayat;

@override
  void initState() {
    listRiwayat = widget.riwayatData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                RiwayatModel list = listRiwayat[index];
                return RiwayatCard(
                  namaToko: list.namaToko,
                  fotoProduk: list.fotoProduk,
                  namaProduk: list.namaProduk,
                  variasiWarna: list.warna,
                  variasiUkuran: list.ukuran,
                  qty: list.qty,
                  harga: list.harga,
                  totalPesanan: list.totalPesanan,
                  qtyProdukLain: list.qtyProdukLain,
                  rating: list.rating,
                  hari: list.hari,
                  statusTransaksi: list.statusTransaksi,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
              itemCount: listRiwayat.length),
        ),
      ),
    );
  }
}
