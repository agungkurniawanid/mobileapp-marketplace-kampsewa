import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_camp_sewa/components/button/button_versi1.dart';
import 'package:project_camp_sewa/components/input/input_versi1.dart';
import 'package:project_camp_sewa/services/api_register.dart';

class LayoutRegister extends StatefulWidget {
  const LayoutRegister({super.key});

  @override
  State<LayoutRegister> createState() => _LayoutRegisterState();
}

class _LayoutRegisterState extends State<LayoutRegister> {
  ApiRegistrasi apiRegistrasi = Get.put(ApiRegistrasi());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFFE8E9EC),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: Color(0xFFE8E9EC)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1a/58/bc/c7/senaru-crater-rim-2-days.jpg?w=1200&h=-1&s=1"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("REGISTRASI",
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 5),
              child: InputVersiSatu(
                controller: apiRegistrasi.namaController,
                tipeInput: TextInputType.name,
                showEyes: false,
                iconInput: const Icon(Icons.person_outline),
                placeHolder: "Username",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 5),
              child: InputVersiSatu(
                controller: apiRegistrasi.emailController,
                tipeInput: TextInputType.emailAddress,
                showEyes: false,
                iconInput: const Icon(Icons.email_rounded),
                placeHolder: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 5),
              child: InputVersiSatu(
                controller: apiRegistrasi.phoneNumberController,
                tipeInput: TextInputType.phone,
                showEyes: false,
                iconInput: const Icon(Icons.phone),
                placeHolder: "No.Telephone",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 5),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: apiRegistrasi.tanggalLahirController,
                    onTap: () {
                      _selectDate(context);
                    },
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.date_range),
                      hintText: "Tanggal Lahir",
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintStyle:
                          GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 5),
              child: InputVersiSatu(
                // passwordTipe: true,
                controller: apiRegistrasi.passwordController,
                placeHolder: "Password",
                showEyes: true,
                passwordTipe: true,
                iconInput: const Icon(Icons.key_outlined),
                tipeInput: TextInputType.visiblePassword,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: ButtonVersiSatu(
                  aksi: () {
                    apiRegistrasi.registrasi(context);
                  },
                  lebarFull: true,
                  title: "Register",
                  bgTombol: const Color(0xFF010935)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sudah punya akun?", style: GoogleFonts.poppins()),
                      const SizedBox(width: 5),
                      Text("Login!",
                          style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        apiRegistrasi.tanggalLahirController.text = formattedDate;
      });
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Membuat objek path untuk menentukan area yang akan dipotong
    var path = Path();
    // Menentukan titik awal path (pojok kiri atas)
    path.lineTo(0, size.height - 80);
    // Menentukan titik kontrol pertama untuk kurva Bezier pertama
    var firstControlPoint = Offset(size.width / 4, size.height);
    // Menentukan titik akhir kurva Bezier pertama
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    // Menambahkan kurva Bezier pertama ke path
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    // Menentukan titik kontrol kedua untuk kurva Bezier kedua
    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    // Menentukan titik akhir kurva Bezier kedua
    var secondEndPoint = Offset(size.width, size.height - 20);
    // Menambahkan kurva Bezier kedua ke path
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    // Menambahkan garis lurus ke pojok kanan bawah
    path.lineTo(size.width, size.height - 40);
    // Menambahkan garis lurus ke pojok kanan atas
    path.lineTo(size.width, 0);
    // Menutup path sehingga area yang ditentukan oleh path akan dipotong
    path.close();
    // Mengembalikan path yang telah dibuat
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Metode ini digunakan untuk menentukan apakah path perlu dipotong ulang
    // Di sini, kita mengembalikan false karena path tidak perlu diubah.
    return true;
  }
}
