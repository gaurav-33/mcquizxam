import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/toast_snack_bar.dart';
import '../../res/theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/rec_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final height = Get.height;
  final width = Get.width;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          AppTheme.desaturatedBlue,
          AppTheme.darkIndigo,
        ], begin: Alignment.topRight, end: Alignment.bottomRight)),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.05, horizontal: height * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "M C Q U I Z X A M",
                      style: TextStyle(
                          fontSize: width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.veryLightBlue),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Reset Password",
                      style: TextStyle(fontSize: height * 0.035),
                    )
                  ],
                ),
              ),
              // BOX 1
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: height * 0.7,
                  decoration: BoxDecoration(
                      color: AppTheme.lightAqua.withOpacity(.4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(height * .1))),
                ),
              ),
              // BOX 2
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: height * 0.65,
                  width: width * 0.95,
                  decoration: BoxDecoration(
                      color: AppTheme.lightAqua.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(height * .1))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.06),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                      color: AppTheme.darkIndigo, fontSize: 20),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Email",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Email";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                              ],
                            ),
                          ),
                          RecButton(
                            name: "Reset",
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await _auth.sendPasswordResetEmail(
                                      email: emailController.text
                                          .toString()
                                          .trim());
                                  AppSnackBar.success(
                                      "Password reset link sent. Please check email.");
                                  Get.offAllNamed(AppRoutes.getLoginRoute());
                                } catch (e) {
                                  if (e is FirebaseAuthException) {
                                    AppSnackBar.error(
                                        e.message ?? "An error occurred.",
                                        errorCode: e.code);
                                  } else {
                                    AppSnackBar.error(
                                        "An unexpected error occurred.");
                                  }
                                }
                              }
                            },
                            isLoading: false, // Add loading state if needed
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                              onPressed: () {
                                Get.offAllNamed(AppRoutes.getLoginRoute());
                              },
                              child: const Text(
                                "Back to Login.",
                                style: TextStyle(fontSize: 15),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
