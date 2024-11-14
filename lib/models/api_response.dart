import 'package:project_camp_sewa/models/berita_model.dart';
import 'package:project_camp_sewa/models/riwayat_model.dart';
import 'package:project_camp_sewa/models/wisata_model.dart';

class ApiResponse {
  Object? data;
  String? error;
}

class DummyProductApiResponse {
  static final Map<String, dynamic> riwayatBelumBayar = {
    "status": "success",
    "data": [
      {
        'id': 1,
        'nama_toko': "Abay Store",
        'nama_produk': "Kompor Camping Portable",
        'foto_produk': "assets/images/kompor-portable.jpg",
        'qty': "2",
        'deskripsi_produk': "Normal / Hitam",
        'ukuran': "Normal",
        'warna': "Hitam",
        'qty_produk_lain': "6",
        'rating': "7.3",
        'harga': "55.000",
        'total_pesanan': "410.000",
        'durasi': "5",
        'status_transaksi': "Belum Lunas"
      }
    ]
  };

  static final Map<String, dynamic> apiRiwayatPengambilanResponse = {
    "status": "success",
    "data": [
      {
        'id': 1,
        'nama_toko': "Mutiara Store",
        'nama_produk': "Cooler Box Igloo",
        'foto_produk': "assets/images/cooler-box-igloo.jpg",
        'qty': "1",
        'ukuran': "XL",
        'warna': "Abu-abu",
        'qty_produk_lain': "5",
        'rating': "6.3",
        'harga': "30.000",
        'total_pesanan': "320.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 2,
        'nama_toko': "Gungzle Shop",
        'nama_produk': "Gaiter Outdoor",
        'foto_produk': "assets/images/gaiter.jpg",
        'qty': "2",
        'ukuran': "44",
        'warna': "Hitam",
        'qty_produk_lain': "3",
        'rating': "7.3",
        'harga': "35.000",
        'total_pesanan': "160.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      }
    ]
  };
  static final Map<String, dynamic> apiRiwayatBerlangsungResponse = {
    "status": "success",
    "data": [
      {
        'id': 1,
        'nama_toko': "Oxygen Base",
        'nama_produk': "Sepatu Hiking Merrel",
        'foto_produk': "assets/images/sepatu-hiking-merrell.jpg",
        'qty': "1",
        'ukuran': "44",
        'warna': "Abu-abu",
        'qty_produk_lain': "4",
        'rating': "7.0",
        'harga': "55.000",
        'total_pesanan': "290.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 2,
        'nama_toko': "Rumah Outdoor",
        'nama_produk': "Tenda Hammoc",
        'foto_produk': "assets/images/tenda-hammoc.jpg",
        'qty': "2",
        'ukuran': "Double Layer",
        'warna': "Hitam",
        'qty_produk_lain': "6",
        'rating': "3.0",
        'harga': "75.000",
        'total_pesanan': "540.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 2,
        'nama_toko': "Awan Adventure",
        'nama_produk': "Sleeping Bag",
        'foto_produk': "assets/images/slepping-bag.jpg",
        'qty': "4",
        'ukuran': "XL",
        'warna': "Hitam",
        'qty_produk_lain': "4",
        'rating': "6.7",
        'harga': "35.000",
        'total_pesanan': "240.000",
        'durasi': "4",
        'status_transaksi': "Lunas"
      }
    ]
  };

  static final Map<String, dynamic> apiRiwayatSelesaiResponse = {
    "status": "success",
    "data": [
      {
        'id': 1,
        'nama_toko': "Abay Store",
        'nama_produk': "Survival Kit",
        'foto_produk': "assets/images/survival-kit.jpg",
        'qty': "1",
        'ukuran': "Normal",
        'warna': "Hitam",
        'qty_produk_lain': "5",
        'rating': "5.5",
        'harga': "35.000",
        'total_pesanan': "290.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 2,
        'nama_toko': "Rumah Outdoor",
        'nama_produk': "Set Alat Masak Outdoor",
        'foto_produk': "assets/images/set-alat-masak.jpg",
        'qty': "1",
        'ukuran': "Large",
        'warna': "Hitam",
        'qty_produk_lain': "3",
        'rating': "8.2",
        'harga': "40.000",
        'total_pesanan': "210.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 3,
        'nama_toko': "Oxygen Base",
        'nama_produk': "Tenda Dome Coleman",
        'foto_produk': "assets/images/tenda-dome-coleman.jpg",
        'qty': "2",
        'ukuran': "Double Layer",
        'warna': "Abu-abu",
        'qty_produk_lain': "7",
        'rating': "8.8",
        'harga': "125.000",
        'total_pesanan': "660.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 4,
        'nama_toko': "Mutiara Store",
        'nama_produk': "Kursi Lipat",
        'foto_produk': "assets/images/kursi-lipat.jpg",
        'qty': "4",
        'ukuran': "Normal",
        'warna': "Hitam",
        'qty_produk_lain': "5",
        'rating': "6.8",
        'harga': "30.000",
        'total_pesanan': "250.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      },
      {
        'id': 5,
        'nama_toko': "Gungzle Shop",
        'nama_produk': "Raincoat Marmot",
        'foto_produk': "assets/images/raincoat-marmot.jpg",
        'qty': "3",
        'ukuran': "XL",
        'warna': "Hitam",
        'qty_produk_lain': "4",
        'rating': "7.2",
        'harga': "24.000",
        'total_pesanan': "144.000",
        'durasi': "3",
        'status_transaksi': "Lunas"
      }
    ]
  };

  static final Map<String, dynamic> dummyDataBerita = {
    "status": "success",
    "data": [
      {
        'id': 1,
        'judul': "Gelombang Tinggi di Pantai Selatan Gunungkidul",
        'image':
            "https://asset.kompas.com/crops/LUU_OmXJ7a-Q4mHUR2rndhVDQYY=/0x0:0x0/750x500/data/photo/2024/05/28/6655b5605cc47.jpg",
        'source': "Kompas.com",
        'link':
            "https://yogyakarta.kompas.com/read/2024/05/29/102053278/gelombang-tinggi-di-pantai-selatan-gunungkidul-nelayan-dilarang-melaut",
      },
      {
        'id': 2,
        'judul': "Festival Danau Toba di Sumatera Utara",
        'image':
            "https://infopublik.id/assets/upload/headline//F1Powerboat_1.jpg",
        'source': "InfoPublic",
        'link':
            "https://infopublik.id/kategori/nasional-sosial-budaya/826717/f1-powerboat-danau-toba-2024-bakal-diramaikan-sejumlah-band-ternama",
      },
      {
        'id': 3,
        'judul':
            "Pantai Mbuluk di Yogyakarta: Daya Tarik, Harga Tiket, dan Rute:",
        'image':
            "https://asset.kompas.com/crops/gK2lUq_eBZLEtG_1erKmOTyvXLQ=/0x0:998x665/750x500/data/photo/2023/01/31/63d87e488a062.jpg",
        'source': "kompas.com",
        'link': "https://www.kompas.com/tag/pantai-mbuluk-di-yogyakarta",
      },
      {
        'id': 4,
        'judul':
            "Agen Travel dari Rombongan ELf yang Viral Dipanggil Polisi dan BBTNBTS",
        'image':
            "https://akcdn.detik.net.id/community/media/visual/2024/05/25/viral-elf-melewati-lautan-pasir-bromo_169.jpeg?w=700&q=90",
        'source': "detik.com",
        'link':
            "https://travel.detik.com/travel-news/d-7357787/agen-travel-dari-rombongan-elf-yang-viral-dipanggil-polisi-dan-bbtnbts",
      },
      {
        'id': 5,
        'judul': "Sea World Ancol, Eksplorasi Dunia Bawah Laut di Jakarta",
        'image':
            "https://akcdn.detik.net.id/community/media/visual/2024/05/17/sea-world-ancol-jakarta_169.jpeg?w=700&q=90",
        'source': "detik.com",
        'link':
            "https://travel.detik.com/domestic-destination/d-7344305/sea-world-ancol-eksplorasi-dunia-bawah-laut-di-jakarta",
      },
      {
        'id': 6,
        'judul': "Sumba, Permata Tersembunyi di Timur Indonesia",
        'image':
            "https://cdn0-production-images-kly.akamaized.net/kRgYvf_EaO6b4xh67ujT2yGrNbg=/640x360/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/4711964/original/083586400_1704886735-shutterstock_2284006339.jpg",
        'source': "liputan6",
        'link':
            "https://www.liputan6.com/lifestyle/read/5502127/sumba-permata-tersembunyi-di-timur-indonesia",
      },
      {
        'id': 7,
        'judul':
            "Cara Beli Tiket untuk Lihat Penerbangan Lampion Waisak di Borobudur",
        'image':
            "https://akcdn.detik.net.id/community/media/visual/2023/12/23/pelepasan-lampion-di-candi-borobudur-sabtu-23122023-1_169.jpeg?w=700&q=90",
        'source': "detik.net",
        'link':
            "https://travel.detik.com/travel-news/d-7348760/cara-beli-tiket-untuk-lihat-penerbangan-lampion-waisak-di-borobudur",
      },
      {
        'id': 8,
        'judul':
            "Ciremai Land, Tempat Kemah Mewah di Lereng Gunung Tertinggi Jabar",
        'image':
            "https://akcdn.detik.net.id/community/media/visual/2024/05/09/ciremai-land-glamping_169.jpeg?w=700&q=90",
        'source': "detik.net",
        'link':
            "https://www.detik.com/jabar/cirebon-raya/d-7332692/ciremai-land-tempat-kemah-mewah-di-lereng-gunung-tertinggi-jabar",
      },
      {
        'id': 9,
        'judul': "Glamping Pinggir Sungai di Sentul",
        'image':
            "https://akcdn.detik.net.id/community/media/visual/2024/05/13/landeuh-village-riverside-glamping-cabin-5.jpeg?w=700&q=90",
        'source': "detik.net",
        'link':
            "https://travel.detik.com/fototravel/d-7337997/foto-glamping-pinggir-sungai-di-sentul/2",
      },
    ]
  };
  static final Map<String, dynamic> dummyDataWisata = {
    "status": "success",
    "data": [
      {
        "image": "assets/wisata/gunung-bromo.jpg",
        "deskripsi":
            "Gunung berapi aktif dengan pemandangan sunrise yang menakjubkan.",
        "wisata": "Gunung Bromo",
        "lokasi": "Jawa Timur",
        "source": "https://bookingbromo.bromotenggersemeru.org/"
      },
      {
        "image": "assets/wisata/puncak-lawang.jpg",
        "deskripsi": "Pemandangan Danau Maninjau dari ketinggian yang memukau.",
        "wisata": "Puncak Lawang",
        "lokasi": "Sumatera Barat",
        "source": "https://medan.kompas.com/read/2022/01/28/132341878/puncak-lawang-harga-tiket-masuk-jam-buka-dan-keindahan-di-dalamnya?page=all"
      },
      {
        "image": "assets/wisata/gunung-semeru.jpg",
        "deskripsi": "Gunung tertinggi di Pulau Jawa, populer untuk pendakian.",
        "wisata": "Gunung Semeru",
        "lokasi": "Jawa Timur",
        "source": "https://bookingsemeru.bromotenggersemeru.org/index/blog"
      },
      {
        "image": "assets/wisata/gunung-salak.jpg",
        "deskripsi": "Gunung berapi yang terkenal dengan jalur pendakiannya.",
        "wisata": "Gunung Salak",
        "lokasi": "Jawa Barat",
        "source": "https://halimunsalak.org/sop-pendakian-gunung-salak/"
      },
      {
        "image": "assets/wisata/gunung-rinjani.jpg",
        "deskripsi": "Gunung berapi aktif dengan danau kawah yang indah.",
        "wisata": "Gunung Rinjani",
        "lokasi": "Nusa Tenggara Barat",
        "source": "https://indonesiakaya.com/pustaka-indonesia/gunung-rinjani-pesona-keindahan-alam-eksotis-di-atap-lombok/"
      },
      {
        "image": "assets/wisata/ranu-kumbolo.jpg",
        "deskripsi":
            "Danau indah di kaki Gunung Semeru, spot berkemah populer.",
        "wisata": "Ranu Kumbolo",
        "lokasi": "Jawa Timur",
        "source": "https://www.pesonaindo.com/tours/paket-wisata-ranu-kumbolo/"
      },
      {
        "image": "assets/wisata/gunung-batur.jpg",
        "deskripsi": "Gunung berapi dengan pemandangan sunrise yang mempesona.",
        "wisata": "Gunung Batur",
        "lokasi": "Bali",
        "source": "https://www.goodnewsfromindonesia.id/2022/11/14/gunung-batur-gunung-berapi-di-bali-dengan-panoramanya-yang-indah"
      },
      {
        "image": "assets/wisata/bukit-sikunir.jpg",
        "deskripsi": "Spot melihat sunrise dengan pemandangan spektakuler.",
        "wisata": "Bukit Sikunir",
        "lokasi": "Jawa Tengah",
        "source": "https://bob.kemenparekraf.go.id/307606-bukit-sikunir-dieng-wisata-mengagumkan-di-wonosobo/"
      },
      {
        "image": "assets/wisata/gunung-lawu.jpg",
        "deskripsi":
            "Gunung dengan sejarah mistis dan jalur pendakian populer.",
        "wisata": "Gunung Lawu",
        "lokasi": "Jawa Tengah",
        "source": "https://pesonakaranganyar.karanganyarkab.go.id/destinasi/daya-tarik-wisata/pendakian-lawu-via-tambak"
      },
      {
        "image": "assets/wisata/pantai-klayar.jpg",
        "deskripsi": "Pantai dengan batu karang unik dan pemandangan indah.",
        "wisata": "Pantai Klayar",
        "lokasi": "Jawa Timur",
        "source": "https://indonesiakaya.com/pustaka-indonesia/pantai-klayar-kekayaan-tersembunyi-di-bumi-pacitan/"
      },
      {
        "image": "assets/wisata/kawah-ijen.jpg",
        "deskripsi": "Gunung berapi dengan kawah biru dan api biru.",
        "wisata": "Gunung Ijen",
        "lokasi": "Jawa Timur",
        "source": "https://www.indonesia.travel/id/id/destinasi/java/kawah-ijen.html"
      },
      {
        "image": "assets/wisata/ranu-regulo.jpg",
        "deskripsi": "Danau alami yang tenang di kaki Gunung Semeru.",
        "wisata": "Ranu Regulo",
        "lokasi": "Jawa Timur",
        "source":
            "https://travel.kompas.com/read/2023/01/25/090400727/wisata-ranu-regulo--harga-tiket-rute-aktivitas-dan-tips-berkunjung?page=all"
      }
    ]
  };

  static List<RiwayatModel> getRiwayatBelumBayar() {
    List<dynamic> riwayatData = riwayatBelumBayar['data'];
    return riwayatData.map((data) => RiwayatModel.fromJson(data)).toList();
  }

  static List<RiwayatModel> getRiwayatPengambilanData() {
    List<dynamic> riwayatData = apiRiwayatPengambilanResponse['data'];
    return riwayatData.map((data) => RiwayatModel.fromJson(data)).toList();
  }
  static List<RiwayatModel> getRiwayatBerlangsung() {
    List<dynamic> riwayatData = apiRiwayatBerlangsungResponse['data'];
    return riwayatData.map((data) => RiwayatModel.fromJson(data)).toList();
  }
  static List<RiwayatModel> getRiwayatSelesai() {
    List<dynamic> riwayatData = apiRiwayatSelesaiResponse['data'];
    return riwayatData.map((data) => RiwayatModel.fromJson(data)).toList();
  }

  static List<BeritaModel> getDataBerita() {
    List<dynamic> beritaData = dummyDataBerita['data'];
    return beritaData.map((data) => BeritaModel.fromJson(data)).toList();
  }
  static List<WisataModel> getDataWisata() {
    List<dynamic> wisataData = dummyDataWisata['data'];
    return wisataData.map((data) => WisataModel.fromJson(data)).toList();
  }
}
