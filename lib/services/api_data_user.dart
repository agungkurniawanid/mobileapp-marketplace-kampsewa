// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:project_camp_sewa/components/dialog/alert_dialog.dart';
import 'package:project_camp_sewa/components/dialog/loading_dialog.dart';
import 'package:project_camp_sewa/components/dialog/snackbar.dart';
import 'package:project_camp_sewa/constants/api_endpoint.dart';
import 'package:project_camp_sewa/models/alamat_model.dart';
import 'package:project_camp_sewa/models/user.dart';
import 'package:project_camp_sewa/services/api_transaksi.dart';
import 'package:project_camp_sewa/services/authorization_token.dart';
import 'package:project_camp_sewa/services/controller_dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiDataUser extends GetxController {
  ApiTransaksi apiTransaksi = Get.put(ApiTransaksi());
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController detailAlamatController = TextEditingController();
  TextEditingController namaTokoController = TextEditingController();
  TextEditingController detailAlamatTokoController = TextEditingController();
  TextEditingController noRekController = TextEditingController();
  TextEditingController jenisBankController = TextEditingController();
  Dio dio = Dio();
  LoadingDialog loading = Get.put(LoadingDialog());
  DashboardController pageController = Get.put(DashboardController());
  final Rx<User?> dataUser = Rx<User?>(null);
  final RxList<AlamatUserModel> listAlamatUser = <AlamatUserModel>[].obs;

  Future<void> getDataUser(BuildContext context) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      int? id = await auth.getId();
      String idStr = id.toString();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url =
          ApiEndpoints.baseUrl + ApiEndpoints.authendpoints.getDataUser + idStr;

      final response = await dio.get(url,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> data =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        // listDataUser =
        //     List.from(dataUser['user']).map((e) => User.fromJson(e)).toList();
        dataUser.value = User.fromJson(data['data_users']);
        final User? attachData = dataUser.value;
        namaController.text = attachData!.name!;
        emailController.text = attachData.email!;
        phoneNumberController.text = attachData.nomorTelephone!;
        tanggalLahirController.text = attachData.tanggalLahir!;
      } else {
        String errorMessage = data['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              title: "Error",
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: CustomAlertDialog(
                  sukses: false,
                  teks: dioError.message ?? "An unknown error occurred",
                ),
              );
            });
      }
    }
  }

  Future<void> updateProfile(BuildContext context, XFile? photoProfile) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      int? id = await auth.getId();
      String idStr = id.toString();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = ApiEndpoints.baseUrl +
          ApiEndpoints.authendpoints.updateDataUser +
          idStr;
      FormData formData = FormData.fromMap({
        'name': namaController.text,
        'email': emailController.text.trim(),
        'nomor_telephone': phoneNumberController.text,
        'tanggal_lahir': tanggalLahirController.text,
        if (photoProfile != null)
          'foto': await MultipartFile.fromFile(photoProfile.path,
              filename: "$idStr-${photoProfile.path.split('/').last}"),
      });

      final response = await dio.post(url,
          data: formData,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! <= 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: "Profile Berhasil di Update",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        namaController.clear();
        emailController.clear();
        phoneNumberController.clear();
        tanggalLahirController.clear();
        if (context.mounted) {
          pageController.setPageIndex(3);
          getDataUser(context);
          Get.back();
        }
      } else {
        String errorMessage = json['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }

  Future<void> tambahAlamatUser(BuildContext context, String latitude,
      String longitude, String type) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      int? id = await auth.getId();
      String idStr = id.toString();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url =
          ApiEndpoints.baseUrl + ApiEndpoints.authendpoints.tambahAlamatUser;
      Map body = {
        'id_user': idStr,
        'longitude': longitude,
        'latitude': latitude,
        if (detailAlamatController.text.isNotEmpty)
          'detail_lainnya': detailAlamatController.text,
        if (type == "Rumah") 'type': 0 else 'type': 2
      };

      final response = await dio.post(url,
          data: body,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! <= 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: "Berhasil Menambahkan Alamat",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        if (context.mounted) {
          //get data alamat supaya memperbarui data di layout alamat
          getListAlamatUser(context);
          Get.back();
        }
      } else {
        String errorMessage = json['error'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }

  Future<void> getListAlamatUser(BuildContext context) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      int? id = await auth.getId();
      String idStr = id.toString();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url =
          "${ApiEndpoints.baseUrl}${ApiEndpoints.authendpoints.getAlamatUser}$idStr";

      final response = await dio.get(url,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> data =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        List<AlamatUserModel> alamatList = List<AlamatUserModel>.from(
            data['alamat_user']
                .map((e) => AlamatUserModel.fromJson(e))
                .toList());
        listAlamatUser.assignAll(alamatList);
      } else {
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: "Data Produk Gagal Dimuat",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: CustomAlertDialog(
                  sukses: false,
                  teks: dioError.message ?? "An unknown error occurred",
                ),
              );
            });
      }
    }
  }

  Future<void> updateAlamatUser(BuildContext context, String idAlamat,
      String latitude, String longitude, String type) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = ApiEndpoints.baseUrl +
          ApiEndpoints.authendpoints.updateAlamatUser +
          idAlamat;

      Map body = {
        'longitude': longitude,
        'latitude': latitude,
        if (detailAlamatController.text.isNotEmpty)
          'detail_lainnya': detailAlamatController.text,
        if (type == "Rumah") 'type': 0 else 'type': 2
      };

      final response = await dio.put(url,
          data: body,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: "Profile Berhasil di Update",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        if (context.mounted) {
          getListAlamatUser(context);
          Get.back();
        }
      } else {
        String errorMessage = json['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }

  Future<void> deleteAlamatUser(BuildContext context, String idAlamat) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = ApiEndpoints.baseUrl +
          ApiEndpoints.authendpoints.deleteAlamatUser +
          idAlamat;

      final response = await dio.delete(url,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: "Alamat Berhasil Dihapus",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        if (context.mounted) {
          getListAlamatUser(context);
          Get.back();
        }
      } else {
        String errorMessage = json['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }

  Future<void> tambahBankMetodeTransfer(BuildContext context) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      int? id = await auth.getId();
      String idStr = id.toString();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = ApiEndpoints.baseUrl +
          ApiEndpoints.authendpoints.tambahBankMetodeTransfer;

      Map body = {
        'id_user': idStr,
        'rekening': noRekController.text,
        'bank': jenisBankController.text,
      };

      final response = await dio.post(url,
          data: body,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: "Berhasil Menambahkan Metode Transfer",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        if (context.mounted) {
          apiTransaksi.getBankOpsiPembayaran(context, idStr);
          Get.back();
        }
      } else {
        String errorMessage = json['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }

  Future<void> isiDataToko(
      BuildContext context, String latitude, String longitude) async {
    try {
      Authorization auth = Authorization();
      String? token = await auth.getToken();
      int? id = await auth.getId();
      String idStr = id.toString();
      var header = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = ApiEndpoints.baseUrl + ApiEndpoints.authendpoints.isiDataToko + idStr;

      Map body = {
        'name_store': namaTokoController.text,
        'longitude': longitude,
        'latitude': latitude,
        'detail_lainnya': detailAlamatTokoController.text,
      };

      final response = await dio.post(url,
          data: body,
          options: Options(
            headers: header,
            validateStatus: (status) {
              return status! < 500; // Accept status codes less than 500
            },
          ));

      final Map<String, dynamic> json =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (response.statusCode == 200) {
        final Uri url = Uri.parse(ApiEndpoints.baseUrl);
          await launchUrl(url);
        const snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: true,
              teks: "Berhasil Menambahkan Data Toko",
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        if (context.mounted) {
          Get.back();
        }
      } else {
        String errorMessage = json['message'];
        final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: CustomSnackBar(
              sukses: false,
              teks: errorMessage,
            ));

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } on DioException catch (dioError) {
      if (context.mounted) {
        if (context.mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: CustomAlertDialog(
                    sukses: false,
                    teks: dioError.message ?? "An unknown error occurred",
                  ),
                );
              });
        }
      }
    }
  }
}
