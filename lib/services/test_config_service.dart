import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/test_config_model.dart';
import '../services/firestore_ref_service.dart';
import '../utils/toast_snack_bar.dart';

class TestConfigService {
  late final FirestoreRefService _firestoreRefService;

  TestConfigService() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<TestConfigModel?> fetchTestConfig() async {
    try {
      DocumentSnapshot<TestConfigModel> snapshot = await _firestoreRefService
          .testConfigCollectionRef
          .doc('settings')
          .get();
      return snapshot.data();
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
    return null;
  }
}
