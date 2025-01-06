import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../shared_preference/user_preferences.dart';
import '../utils/toast_snack_bar.dart';

import '../models/user_model.dart';
import '../services/home_service.dart';

class HomeController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString uid = ''.obs;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final HomeService _homeService = Get.find<HomeService>();

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    UserModel? savedUserModel = await UserPreferences.getUser();
    try {
      if (savedUserModel == null) {
        User? fireBaseUser = auth.currentUser;
        if (fireBaseUser == null) {
          AppSnackBar.error("User not logged In.");
          Get.offAllNamed(AppRoutes.getLoginRoute());
        } else {
          String uid = fireBaseUser.uid;
          savedUserModel = await _homeService.fetchUser(uid);
          await UserPreferences.saveUser(savedUserModel!);
        }
      }
      firstName.value = savedUserModel!.firstName;
      lastName.value = savedUserModel.lastName!;
      email.value = savedUserModel.email;
      uid.value = savedUserModel.uid;
    } catch (e) {
      if (e is FirebaseAuthException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    }
  }
}
