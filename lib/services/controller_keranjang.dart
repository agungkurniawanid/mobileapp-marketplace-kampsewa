import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/constants/database_helper.dart';

class KeranjangController extends GetxController {
  var selectedProdukCheckout = <Map<String, dynamic>>[].obs;
  var uniqueStores = <Map<String, dynamic>>[].obs;
  final RxInt totalHargaKeranjang = 0.obs;
  final RxInt totalItemKeranjang = 0.obs;
  final RxInt totalSelectedTokoCheckout = 0.obs;  //ini buat ngecek apakah barang yang dichekout dari 1 toko atau tidak karena terdapat problem di pembayarannya jika chekout dari berbagai toko sekaligus

  Future<void> getSelectedProdukCheckout(BuildContext context) async {
    List<Map<String, dynamic>> produkCheckout =
        await DatabaseHelper.instance.getSelectedProdukCheckout(context);
    selectedProdukCheckout.assignAll(produkCheckout);
  }

  void getUniqueStores(BuildContext context) async {
    List<Map<String, dynamic>> stores =
        await DatabaseHelper.instance.getUniqueStores(context);
    uniqueStores.assignAll(stores);
  }

  void updateTotalHargaKeranjang(BuildContext context) async {
    int totalHarga = await DatabaseHelper.instance.getTotalHargaKeranjang(context);
    totalHargaKeranjang.value = totalHarga;
  }
  void updateTotalItemKeranjang(BuildContext context) async {
    int totalItem = await DatabaseHelper.instance.getCountSelectedProduk(context);
    totalItemKeranjang.value = totalItem;
  }

  Future<void> getSelectedTokoCheckout(BuildContext context) async {
    int totalToko = await DatabaseHelper.instance.getCountSelectedTokoCheckout(context);
    totalSelectedTokoCheckout.value = totalToko;
  }
}
