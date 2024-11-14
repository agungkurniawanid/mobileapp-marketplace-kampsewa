import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingDialog {
  void showLoadingDialog() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        const Center(
            child: SpinKitFadingCircle(
          color: Colors.white,
          size: 55,
        )),
        barrierDismissible: false,
      );
    }
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
