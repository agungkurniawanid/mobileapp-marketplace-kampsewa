import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/components/card/chekout_produk_card.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/layouts/layout_metode_pembayaran.dart';
import 'package:project_camp_sewa/layouts/layout_opsi_pengiriman.dart';
import 'package:project_camp_sewa/models/keranjang_model.dart';
import 'package:project_camp_sewa/services/api_transaksi.dart';
import 'package:project_camp_sewa/services/controller_keranjang.dart';

class LayoutCheckout extends StatefulWidget {
  const LayoutCheckout({super.key});

  @override
  State<LayoutCheckout> createState() => _LayoutCheckoutState();
}

class _LayoutCheckoutState extends State<LayoutCheckout> {
  KeranjangController keranjangController = Get.put(KeranjangController());
  ApiTransaksi apiTransaksi = Get.put(ApiTransaksi());
  String metodeBayar = "Bayar Ditempat";
  String opsiPengiriman =
      "Ambil Ditempat"; //untuk alamat pengirimannya nanti isi alamat store langsung dari API
  String? jenisBank;
  DateTime? tanggalAwal;
  DateTime? tanggalAkhir;
  DateTimeRange durasiSewa =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  String? formatedTanggalAwal;
  String? formatedTanggalAkhir;
  int? totalPembayaran;
  double? longitudeToko;
  double? latitudeToko;
  RxString alamatPengiriman = "sedang mendapatkan alamat...".obs;
  int? idToko;
  RxString namaToko = "".obs;
  String? rekeningBank;

  @override
  void initState() {
    super.initState();
    keranjangController.getSelectedProdukCheckout(context);
    keranjangController.updateTotalItemKeranjang(context);
    keranjangController.updateTotalHargaKeranjang(context);
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await keranjangController.getSelectedProdukCheckout(context);

    final List<Map<String, dynamic>> produkCheckout =
        keranjangController.selectedProdukCheckout.toList();

    if (produkCheckout.isNotEmpty) {
      final KeranjangModel keranjang =
          KeranjangModel.fromMap(produkCheckout[0]);
      idToko = keranjang.idToko;
      namaToko.value = keranjang.namaToko;
      // ignore: use_build_context_synchronously
      await apiTransaksi.getAlamatToko(context, idToko.toString());
      final alamat = apiTransaksi.alamatTokoCheckout.value;
      if (alamat != null) {
        longitudeToko = double.parse(alamat.longitude);
        latitudeToko = double.parse(alamat.latitude);
        String convertedAlamat =
            await convertAlamat(latitudeToko!, longitudeToko!);
        alamatPengiriman.value = convertedAlamat;
      }
    }
  }

  Future<String> convertAlamat(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String jalan = placemark.street ?? '';
      String postalCode = placemark.postalCode ?? '';
      String kecamatan = placemark.subLocality ?? '';
      String kabupaten = placemark.locality ?? '';
      String provinsi = placemark.administrativeArea ?? '';
      String alamat = "$jalan, $kecamatan, $kabupaten, $provinsi, $postalCode";
      return alamat;
    } else {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Tidak bisa Mengkonversi koordinat alamat anda",
          ));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return "";
    }
  }

  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter =
        NumberFormat.decimalPattern('id'); // Use 'id' for Indonesian locale
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 15),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 28,
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4 - 10,
                ),
                Text(
                  "Checkout",
                  style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ]),
            ),
            Container(
              color: Colors.black.withOpacity(0.25),
              height: 2,
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: const Color(0xFF010935),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 5, top: 3, bottom: 3),
                            child: Image.asset(
                              "assets/icons/icon-store.png",
                              scale: 2,
                            ),
                          ),
                          Obx(() => Text(
                              namaToko.value,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),) 
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    final List<Map<String, dynamic>> produkCheckout =
                        keranjangController.selectedProdukCheckout.toList();
                    return ListView.builder(
                        itemCount: produkCheckout.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final KeranjangModel keranjang =
                              KeranjangModel.fromMap(produkCheckout[index]);
                          return CheckoutProdukCard(
                            image: keranjang.fotoProduk,
                            namaProduk: keranjang.namaProduk,
                            variasiWarna: keranjang.variantWarna,
                            variasiUkuran: keranjang.variantUkuran,
                            hargaProduk: keranjang.harga.toString(),
                            qtyProduk: keranjang.qty.toString(),
                          );
                        });
                  }),
                  InkWell(
                    onTap: () async {
                      final tanggalSewa = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 90)));

                      if (tanggalSewa != null) {
                        setState(() {
                          durasiSewa = tanggalSewa;
                          tanggalAwal = tanggalSewa.start;
                          tanggalAkhir = tanggalSewa.end;
                          formatedTanggalAwal =
                              DateFormat('yyyy-MM-dd').format(tanggalAwal!);
                          formatedTanggalAkhir =
                              DateFormat('yyyy-MM-dd').format(tanggalAkhir!);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.black.withOpacity(0.3))),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 2),
                              child: Text(
                                "Tentukan Tanggal Sewa",
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 6, top: 5, bottom: 5),
                                  child: Image.asset(
                                    "assets/icons/calendar-icon.png",
                                    scale: 1.5,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Tanggal Mulai : ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          tanggalAwal != null
                                              ? formatedTanggalAwal!
                                              : "-", //teks tanggal awal
                                          style: GoogleFonts.poppins(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Tanggal Akhir : ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          tanggalAkhir != null
                                              ? formatedTanggalAkhir!
                                              : "-", //teks tanggal akhir
                                          style: GoogleFonts.poppins(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.black,
                                  size: 25,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final pilihanPengiriman = await Get.to(
                          const LayoutOpsiPengiriman(),
                          arguments: {'idToko': idToko.toString()});
                      setState(() {
                        if (pilihanPengiriman != null) {
                          opsiPengiriman = pilihanPengiriman['selectedOption'];
                          alamatPengiriman.value = pilihanPengiriman['alamat'];
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: Colors.black.withOpacity(0.25))),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 4),
                              child: Text(
                                "Opsi Pengiriman",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  //opsi pengiriman
                                  opsiPengiriman,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Image.asset(
                                  "assets/icons/tiket-icon.png",
                                  scale: 2.1,
                                ),
                                Text(
                                  "IDR. 0,00",
                                  style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.black,
                                  size: 25,
                                )
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Obx(
                                () => Text(
                                  //alamat
                                  alamatPengiriman.value,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/box-kirim.png",
                                  scale: 2,
                                ),
                                Text(
                                  "Ambil barang sesuai dengan tanggal yang ditentukan",
                                  style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFCD1B1B)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.black.withOpacity(0.25),
                                width: 1.2)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Pesan : ",
                              style: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: TextField(
                                controller: apiTransaksi.pesanController,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(
                                    fontSize: 11, fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText:
                                      "Silahkan tinggalkan pesan tambahan jika ada",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.black.withOpacity(0.25),
                                width: 0.5)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            "Total Produk : ",
                            style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Obx(
                            () => Text(
                              keranjangController.totalItemKeranjang.value
                                  .toString(), //total produk
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            " Produk",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final pilihanPembayaran = await Get.to(
                          const LayoutMetodePembayaran(),
                          arguments: {'idToko': idToko.toString()});
                      setState(() {
                        if (pilihanPembayaran != null) {
                          metodeBayar = pilihanPembayaran["metodeBayar"];
                          jenisBank = pilihanPembayaran["jenisBank"];
                          rekeningBank = pilihanPembayaran["rekeningBank"];
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: Colors.black.withOpacity(0.25),
                                  width: 1.2)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 2, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/coin-icon.png",
                              scale: 2,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Metode Pembayaran",
                              style: GoogleFonts.poppins(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            Text(
                              jenisBank != null
                                  ? "$metodeBayar - ${jenisBank!}"
                                  : metodeBayar, //metode pembayaran
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const Icon(
                              Icons.navigate_next_rounded,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.calendarText,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Rincian Pembayaran",
                          style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 20, 6),
                    child: Row(
                      children: [
                        Text(
                          "Durasi Sewa",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "${durasiSewa.duration.inDays}", //durasi sewa
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          " Hari",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 20, 6),
                    child: Row(
                      children: [
                        Text(
                          "Sub Total Produk",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "IDR. ",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Obx(
                          () {
                            int subTotal =
                                keranjangController.totalHargaKeranjang.value;
                            int durasi = durasiSewa.duration.inDays == 0
                                ? 1
                                : durasiSewa.duration.inDays;
                            int grandTotal = subTotal * durasi;
                            return Text(
                              formatCurrency(
                                  grandTotal.toString()), //sub total harga
                              style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            );
                          },
                        ),
                        Text(
                          ",00",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 20, 6),
                    child: Row(
                      children: [
                        Text(
                          "Biaya Layanan",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "IDR. ",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          "1.000", //sub total harga
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          ",00",
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 20, 6),
                    child: Row(
                      children: [
                        Text(
                          "Total Pembayaran",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "IDR. ",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Obx(() {
                          int subTotal =
                              keranjangController.totalHargaKeranjang.value;
                          int durasi = durasiSewa.duration.inDays == 0
                              ? 1
                              : durasiSewa.duration.inDays;
                          int grandTotal = subTotal * durasi;
                          totalPembayaran = grandTotal + 1000;
                          return Text(
                            totalPembayaran != null
                                ? formatCurrency(totalPembayaran.toString())
                                : "0.00", //total pembayaran
                            style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          );
                        }),
                        Text(
                          ",00",
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.25),
                    height: 2,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () {
                  //button checkout
                  //jangan lupa ngecek apakah udah menginputkan tanggal sewanya
                  if (tanggalAwal != null && tanggalAkhir != null) {
                    String metode =
                        metodeBayar == "Bayar Ditempat" ? "COD" : "Transfer";
                    apiTransaksi.transaksiCheckout(
                        context,
                        formatedTanggalAwal!,
                        formatedTanggalAkhir!,
                        metode,
                        totalPembayaran.toString(),
                        jenisBank,
                        rekeningBank!,
                        idToko);
                  } else {
                    const snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: CustomSnackBar(
                          sukses: false,
                          title: "Notifikasi",
                          teks: "Masukkan Tanggal Sewa Terlebih Dahulu",
                        ));

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }
                },
                child: Container(
                  height: 58,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF010935)),
                  child: Center(
                    child: Text(
                      "Lanjut Pembayaran",
                      style: GoogleFonts.poppins(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
