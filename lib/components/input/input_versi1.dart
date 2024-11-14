import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputVersiSatu extends StatefulWidget {
  final TextInputType tipeInput;
  final String placeHolder;
  final double ukuranFontPlaceHolder;
  final double ketebalanBorder;
  final Color warnaBgInput;
  final Icon iconInput;
  final bool border;
  final bool passwordTipe;
  final bool showEyes;
  final TextEditingController controller;
  const InputVersiSatu(
      {super.key,
      required this.tipeInput,
      required this.controller,
      this.placeHolder = "Masukkan Tipe",
      this.warnaBgInput = Colors.white,
      this.ketebalanBorder = 1,
      this.border = false,
      this.showEyes = false,
      this.passwordTipe = false,
      this.iconInput = const Icon(Icons.email_outlined),
      this.ukuranFontPlaceHolder = 14});

  @override
  State<InputVersiSatu> createState() => _InputVersiSatuState();
}

class _InputVersiSatuState extends State<InputVersiSatu> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.warnaBgInput,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: widget.border ? Colors.black : Colors.transparent,
              width: widget.border ? widget.ketebalanBorder : 0)),
      child: TextField(
        obscureText: widget.passwordTipe ? _obscureText : false,
        keyboardType: widget.tipeInput,
        controller: widget.controller,
        style: GoogleFonts.poppins(fontSize: 16.5, fontWeight: FontWeight.w400, color: Colors.black),
        decoration: InputDecoration(
            hintText: widget.placeHolder,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: GoogleFonts.poppins(
                color: Colors.grey, fontSize: widget.ukuranFontPlaceHolder),
            suffixIcon: widget.showEyes
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText =
                            !_obscureText; // Ubah status teks tersembunyi
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  )
                : null,
            prefixIcon: widget.iconInput),
      ),
    );
  }
}
