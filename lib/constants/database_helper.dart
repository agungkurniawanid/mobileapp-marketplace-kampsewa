// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('keranjang.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE keranjang (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_toko INTEGER,
        nama_toko TEXT,
        id_produk INTEGER,
        foto_produk TEXT,
        nama_produk TEXT,
        variant_warna TEXT,
        variant_ukuran TEXT,
        harga INTEGER,
        qty INTEGER,
        selected INTEGER
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> insertKeranjang(
      Map<String, dynamic> row, BuildContext context) async {
    final db = await instance.database;

    try {
      await db.insert('keranjang', row);
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: true,
            teks: "Berhasil Memasukkan Produk Ke Keranjang",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Memasukkan Produk ke Keranjang",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<int> updateKeranjang(
      int id, Map<String, dynamic> row, BuildContext context) async {
    final db = await instance.database;

    try {
      return await db.update(
        'keranjang',
        row,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal mengupdate data produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<int> deleteKeranjang(int id, BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db.delete(
        'keranjang',
        where: 'id = ?',
        whereArgs: [id],
      );
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: true,
            teks: "Berhasil Menghapus Produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Menghapus Produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<int> deleteKeranjangCheckout(BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db.delete(
        'keranjang',
        where: 'selected = 1',
      );
      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Menghapus Produk Chekout",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<int> deleteAllKeranjang(BuildContext context) async {
    final db = await instance.database;

    try {
      int result = await db.delete('keranjang');

      const snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: CustomSnackBar(
          sukses: true,
          teks: "Berhasil Menghapus Semua Produk",
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Menghapus Produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getUniqueStores(
      BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db
          .rawQuery('SELECT DISTINCT id_toko, nama_toko FROM keranjang');
      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Mengambil Nama Toko",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getKeranjangByIdToko(
      BuildContext context, int idToko) async {
    final db = await instance.database;

    try {
      final result = await db.query(
        'keranjang',
        where: 'id_toko = ?',
        whereArgs: [idToko],
      );
      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Menghapus Produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return [];
    }
  }

  Future<int> getTotalHargaKeranjang(BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db.rawQuery(
          'SELECT SUM(harga * qty) as total_harga FROM keranjang Where selected = 1');
      if (result.isNotEmpty && result.first['total_harga'] != null) {
        return (result.first['total_harga'] as num).toInt();
      } else {
        return 0;
      }
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Mendapatkan Total Harga",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<int> getCountSelectedProduk(BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db.rawQuery(
          'SELECT COUNT(id_produk) as total_item FROM keranjang Where selected = 1');
      if (result.isNotEmpty && result.first['total_item'] != null) {
        return (result.first['total_item'] as num).toInt();
      } else {
        return 0;
      }
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Mendapatkan Selected Produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<int> getCountSelectedTokoCheckout(BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db.rawQuery(
          'SELECT COUNT(DISTINCT id_toko) as selected_toko FROM keranjang Where selected = 1');
      if (result.isNotEmpty && result.first['selected_toko'] != null) {
        return (result.first['selected_toko'] as num).toInt();
      } else {
        return 0;
      }
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Mendapatkan Total Toko yang Dipilih",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getSelectedProdukCheckout(
      BuildContext context) async {
    final db = await instance.database;

    try {
      final result =
          await db.rawQuery('SELECT * FROM keranjang Where selected = 1');
      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Mengambil Nama Toko",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> listInputProdukCheckout(
      //mengambil produk yang nantinya dimasukkin ke database
      BuildContext context) async {
    final db = await instance.database;

    try {
      final result = await db.rawQuery(
          'SELECT id_produk, variant_warna as warna, variant_ukuran as ukuran, qty, harga*qty as subtotal FROM keranjang Where selected = 1');
      return result;
    } catch (e) {
      const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: CustomSnackBar(
            sukses: false,
            teks: "Gagal Mengambil List Produk",
          ));

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return [];
    }
  }
}
