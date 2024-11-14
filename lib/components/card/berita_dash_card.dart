import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BeritaCard extends StatefulWidget {
  final String image;
  final String title;
  final String source;
  final String url;
  const BeritaCard({super.key, required this.image, required this.title, required this.source, required this.url});

  @override
  State<BeritaCard> createState() => _BeritaCardState();
}

class _BeritaCardState extends State<BeritaCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () async {
          final Uri url = Uri.parse(widget.url);
          await launchUrl(url);
        },
        child: Container(
          height: 100,
          width: 370,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF494949).withOpacity(0.3),
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 5.0)
              ]),
          child: Row(
            children: [
              Container(
                height: 85,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.fill)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 6),
                      child: Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.source,
                          style: GoogleFonts.poppins(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF7C7C7C)),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
