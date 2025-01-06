import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../routes/app_routes.dart';
import '../services/firestore_ref_service.dart';
import '../utils/toast_snack_bar.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreRefService firestoreRefService = FirestoreRefService();

  // Reactive state
  RxString emailController = ''.obs;
  RxString passwordController = ''.obs;
  RxString firstNameController = ''.obs;
  RxString lastNameController = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  RxBool canResendEmail = true.obs;
  Rx<User?> firebaseUser = Rx<User?>(null);

  Future<void> signup() async {
    isLoading.value = true;
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.value.trim(),
        password: passwordController.value.trim(),
      );
      firebaseUser.value = userCredential.user;

      if (firebaseUser.value != null) {
        await firebaseUser.value?.sendEmailVerification();
        AppSnackBar.success(
            "Verification email sent. Please verify your email.");
        Get.toNamed(AppRoutes.getEmailVerifyRoute());

        final isVerified = await _waitForEmailVerification();
        if (isVerified) {
          await _createFirestoreUser(userCredential.user!.uid);
          AppSnackBar.success("Account created successfully!");
          Get.offAllNamed(AppRoutes.getLoginRoute());
        } else {
          AppSnackBar.error("Email not verified. Registration incomplete.");
        }
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

  Future<void> _createFirestoreUser(String uid) async {
    final userModel = UserModel(
      firstName: firstNameController.value.trim(),
      lastName: lastNameController.value.trim(),
      email: emailController.value.trim(),
      uid: uid,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
    await firestoreRefService.userCollectionRef.doc(uid).set(userModel);
  }

  Future<bool> _waitForEmailVerification() async {
    final startTime = DateTime.now();
    while (!(firebaseUser.value?.emailVerified ?? false)) {
      await Future.delayed(const Duration(seconds: 3));
      await firebaseUser.value?.reload();
      firebaseUser.value = _auth.currentUser;
      if (DateTime.now().difference(startTime).inMinutes >= 5) {
        return false;
      }
    }
    return true;
  }

  Future<void> manualCheckVerification() async {
    try {
      await firebaseUser.value?.reload();
      firebaseUser.value = _auth.currentUser;
      if (firebaseUser.value?.emailVerified ?? false) {
        AppSnackBar.success("Email verified successfully.");
        Get.offAllNamed(AppRoutes.getLoginRoute());
      } else {
        AppSnackBar.error(
            "Email is not verified yet. Please check your email.");
      }
    } catch (e) {
      AppSnackBar.error(
          "An error occurred while checking verification status.");
    }
  }

  Future<void> resendVerificationEmail() async {
    if (firebaseUser.value != null) {
      try {
        await firebaseUser.value!.sendEmailVerification();
        AppSnackBar.success("Verification email sent successfully.");
        canResendEmail.value = false;
        Future.delayed(const Duration(seconds: 60), () {
          canResendEmail.value = true;
        });
      } catch (e) {
        AppSnackBar.error(
            "Failed to send verification email. Please try again.");
      }
    } else {
      AppSnackBar.error("No user is logged in to resend the email.");
    }
  }
}
