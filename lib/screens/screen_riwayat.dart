import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_camp_sewa/layouts/layout_riwayat.dart';
import 'package:project_camp_sewa/models/api_response.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  /// Tab Titles
  final List<Tab> _tabs = const [
    Tab(text: 'Belum Bayar'),
    Tab(text: 'Pengambilan'),
    Tab(text: 'Berlangsung'),
    Tab(text: 'Selesai'),
    Tab(text: 'Dibatalkan'),
  ];

  final List<Widget> _bodyTabs = [
     LayoutRiwayat(riwayatData: DummyProductApiResponse.getRiwayatBelumBayar(),),
     LayoutRiwayat(riwayatData: DummyProductApiResponse.getRiwayatPengambilanData(),),
     LayoutRiwayat(riwayatData: DummyProductApiResponse.getRiwayatBerlangsung(),),
     LayoutRiwayat(riwayatData: DummyProductApiResponse.getRiwayatSelesai()),
     const LayoutRiwayat(riwayatData: []),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 25),
                  child: IconButton(
                      onPressed: () {
                        navigator?.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          size: 30, color: Colors.black)),
                ),
                Text(
                  "Riwayat",
                  style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        MdiIcons.magnify,
                        size: 30,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: DefaultTabController(
                  length: 5,
                  child: TabBar(
                    controller: _tabController,
                    tabs: _tabs,
                    labelColor: const Color(0xFF010935),
                    indicatorColor: const Color(0xFF010935),
                    unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  ))),
          Expanded(
            flex: 16,
            child: TabBarView(
              controller: _tabController,
              children: _bodyTabs,
            ),
          ),
        ],
      )),
    );
  }
}
