import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/signup_controller.dart';
import '../../res/theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/rec_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});

  final SignupController signupController = Get.find<SignupController>();

  final height = Get.height;
  final width = Get.width;

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
                      "Verify Your Email",
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
                          Icon(
                            Icons.mark_email_unread_outlined,
                            size: height * 0.1,
                          ),
                          const Text(
                              "We have just sent email verification link on your email. Please check your email and click on that link to verify your email address.",
                              style: TextStyle(
                                  fontSize: 20, color: AppTheme.darkCharcoal),
                              textAlign: TextAlign.justify),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                              "If not auto redirected after verification, click on the 'Continue' button.",
                              style: TextStyle(
                                  fontSize: 15, color: AppTheme.darkCharcoal)),
                          const SizedBox(
                            height: 20,
                          ),
                          RecButton(
                            name: "Continue",
                            onTap: () async {
                              await signupController.manualCheckVerification();
                            },
                            isLoading: false, // Add loading state if needed
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => TextButton(
                              onPressed: signupController.canResendEmail.value
                                  ? signupController.resendVerificationEmail
                                  : null,
                              child: Text(
                                signupController.canResendEmail.value
                                    ? "Re-send Email Link"
                                    : "Wait 60s",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
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
