import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
