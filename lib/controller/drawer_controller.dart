import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../routes/app_routes.dart';
import '../shared_preference/user_preferences.dart';
import '../utils/toast_snack_bar.dart';

class DrawerController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final HomeController _homeController = Get.find<HomeController>();

  Future<void> logout() async {
    await auth.signOut();
    AppSnackBar.success("Logout successfully.");
    await UserPreferences.removeUser();
    Get.offAllNamed(AppRoutes.getLoginRoute());
  }
}
