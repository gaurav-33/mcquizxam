import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/firestore_ref_service.dart';
import '../utils/toast_snack_bar.dart';

class HomeService {
  late final FirestoreRefService _firestoreRefService;

  HomeService() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<UserModel?> fetchUser(String uid) async {
    try {
      DocumentSnapshot<UserModel> snapshot =
          await _firestoreRefService.userCollectionRef.doc(uid).get();
      if (snapshot.exists) {
        return snapshot.data();
      } else {
        AppSnackBar.error("User not found.");
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
    }
    return null;
  }
}
