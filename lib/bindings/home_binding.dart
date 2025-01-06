import 'package:get/get.dart';
import '../services/firestore_ref_service.dart';
import '../services/home_service.dart';
import '../shared_preference/user_preferences.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FirestoreRefService(), permanent: true);
    Get.put(UserPreferences());
    Get.put(HomeService());
    Get.put(HomeController(), permanent: true);
  }
}
