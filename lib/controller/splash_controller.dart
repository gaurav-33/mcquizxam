import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (isLogin()) {
      Get.offNamed(
          AppRoutes.getHomeRoute());
    } else {
      Get.offNamed(AppRoutes.getLoginRoute());
    }
  }

  bool isLogin() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
