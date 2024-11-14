import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';

class CheckoutProdukCard extends StatefulWidget {
  final String? image;
  final String? namaProduk;
  final String variasiWarna;
  final String variasiUkuran;
  final String? hargaProduk;
  final String? qtyProduk;
  const CheckoutProdukCard(
      {super.key,
      this.image,
      this.namaProduk,
      this.variasiWarna = "",
      this.variasiUkuran = "",
      this.hargaProduk,
      this.qtyProduk});

  @override
  State<CheckoutProdukCard> createState() => _CheckoutProdukCardState();
}

class _CheckoutProdukCardState extends State<CheckoutProdukCard> {
  String formatCurrency(String numberString) {
    final number = int.parse(numberString);
    final formatter =
        NumberFormat.decimalPattern('id'); // Use 'id' for Indonesian locale
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal:
                  BorderSide(width: 0.6, color: Colors.black.withOpacity(0.5))),
          color: Colors.white),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(ApiEndpoints.baseUrl +
                              ApiEndpoints.authendpoints.getImageProduk +
                              widget.image!)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF494949).withOpacity(0.2),
                            offset: const Offset(0, 0),
                            blurRadius: 3)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              widget.namaProduk!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            widget.variasiUkuran != "" &&
                                    widget.variasiWarna != ""
                                ? "${widget.variasiUkuran}/${widget.variasiWarna}"
                                : widget.variasiUkuran != ""
                                    ? widget.variasiUkuran
                                    : widget.variasiWarna,
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  //Rating
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "IDR. ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      formatCurrency(widget.hargaProduk!),
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      ",00",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "x",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      widget.qtyProduk!,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
