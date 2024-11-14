import 'package:get/get.dart';

class DashboardController extends GetxController {
  var pageIndex = 0.obs;

  void setPageIndex(int index) {
    pageIndex.value = index;
  }
}