import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../res/theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/rec_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());
  var height = Get.height;
  var width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
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
                    vertical: height * 0.05, horizontal: width * 0.05),
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
                      "Login",
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
                        horizontal: height * 0.04, vertical: height * 0.06),
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
                                  onChanged: (value) => loginController
                                      .emailController.value = value,
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
                                const Text(
                                  "Password",
                                  style: TextStyle(
                                      color: AppTheme.darkIndigo, fontSize: 20),
                                ),
                                Obx(() {
                                  return TextFormField(
                                    onChanged: (value) => loginController
                                        .passwordController.value = value,
                                    obscureText: !loginController.visible.value,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      suffixIcon: loginController.visible.value
                                          ? IconButton(
                                              onPressed: () {
                                                loginController.visible.value =
                                                    false;
                                              },
                                              icon:
                                                  const Icon(Icons.visibility))
                                          : IconButton(
                                              onPressed: () {
                                                loginController.visible.value =
                                                    true;
                                              },
                                              icon: const Icon(
                                                  Icons.visibility_off)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Password";
                                      } else {
                                        return null;
                                      }
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.08,
                          ),
                          Obx(() => RecButton(
                                name: "Login",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginController.isLoading.value != false
                                        ? () {}
                                        : loginController.login();
                                  }
                                },
                                isLoading: loginController.isLoading.value,
                              )),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Get.offAllNamed(AppRoutes.getSignupRoute());
                              },
                              child: const Text(
                                "New Here? SignUp",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: AppTheme.desaturatedBlue),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Get.offAllNamed(
                                    AppRoutes.getForgetPasswordRoute());
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppTheme.desaturatedBlue),
                              ),
                            ),
                          )
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
