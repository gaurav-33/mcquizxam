import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../utils/toast_snack_bar.dart';

class LoginController extends GetxController {
  // Text controllers to capture email and password
  RxString emailController = ''.obs;
  RxString passwordController = ''.obs;

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Loading state
  RxBool isLoading = false.obs;

  // Visibility State
  RxBool visible = false.obs;

  // Login method
  Future<void> login() async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.value.trim(),
        password: passwordController.value.trim(),
      );
      if (_auth.currentUser!.emailVerified) {
        AppSnackBar.success("Logged in successfully!");
        Get.offAllNamed(AppRoutes.getHomeRoute());
      } else {
        AppSnackBar.error("User is not verified. Please check your Email.");
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
