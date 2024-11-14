import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_camp_sewa/layouts/layout_alamat.dart';
import 'package:project_camp_sewa/layouts/layout_checkout.dart';
import 'package:project_camp_sewa/layouts/layout_dashboard.dart';
import 'package:project_camp_sewa/layouts/layout_detail_product.dart';
import 'package:project_camp_sewa/layouts/layout_edit_alamat.dart';
import 'package:project_camp_sewa/layouts/layout_keranjang.dart';
import 'package:project_camp_sewa/layouts/layout_lupa_password.dart';
import 'package:project_camp_sewa/layouts/layout_lupa_password_new_pass.dart';
import 'package:project_camp_sewa/layouts/layout_lupa_password_otp.dart';
import 'package:project_camp_sewa/layouts/layout_metode_pembayaran.dart';
import 'package:project_camp_sewa/layouts/layout_onboarding.dart';
import 'package:project_camp_sewa/layouts/layout_opsi_pengiriman.dart';
import 'package:project_camp_sewa/layouts/layout_pembayaran.dart';
import 'package:project_camp_sewa/layouts/layout_product.dart';
import 'package:project_camp_sewa/layouts/layout_rincian_pesanan.dart';
import 'package:project_camp_sewa/layouts/layout_riwayat.dart';
import 'package:project_camp_sewa/layouts/layout_search_screen.dart';
import 'package:project_camp_sewa/screens/screen_dashboard.dart';
import 'package:project_camp_sewa/screens/screen_login.dart';
import 'package:project_camp_sewa/screens/screen_riwayat.dart';
import 'package:project_camp_sewa/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF32363F),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Marketplace KampSewa Indonesia",
        home: SplashScreen());
  }
}
