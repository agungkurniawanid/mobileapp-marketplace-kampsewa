import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemVariant extends StatefulWidget {
  final String item;
  final bool selected;
  final Function()? aksi;
  const ItemVariant({super.key, required this.item, required this.aksi, this.selected = false});

  @override
  State<ItemVariant> createState() => _ItemVariantState();
}

class _ItemVariantState extends State<ItemVariant> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.aksi,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.selected ? const Color(0xFF010935) : Colors.black,
                width: 1.2),
            borderRadius: BorderRadius.circular(5),
            color: widget.selected ? const Color(0xFF010935) : Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              widget.item,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: widget.selected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
