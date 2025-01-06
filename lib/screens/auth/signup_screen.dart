import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/signup_controller.dart';
import '../../res/theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/rec_button.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final SignupController signupController = Get.put(SignupController());
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
                      "SignUp",
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
                                  "FirstName",
                                  style: TextStyle(
                                      color: AppTheme.darkIndigo, fontSize: 20),
                                ),
                                TextFormField(
                                  onChanged: (value) => signupController
                                      .firstNameController.value = value,
                                  keyboardType: TextInputType.name,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    hintText: "Enter FirstName",
                                    // prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter FirstName";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "LastName",
                                  style: TextStyle(
                                      color: AppTheme.darkIndigo, fontSize: 20),
                                ),
                                TextFormField(
                                  onChanged: (value) => signupController
                                      .lastNameController.value = value,
                                  keyboardType: TextInputType.name,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    hintText: "Enter LastName",
                                    // prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter LastName";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                      color: AppTheme.darkIndigo, fontSize: 20),
                                ),
                                TextFormField(
                                  onChanged: (value) => signupController
                                      .emailController.value = value,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Email",
                                    // prefixIcon: Icon(Icons.email),
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
                                    onChanged: (value) => signupController
                                        .passwordController.value = value,
                                    obscureText:
                                        !signupController.isVisible.value,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      // prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: signupController
                                              .isVisible.value
                                          ? IconButton(
                                              onPressed: () {
                                                signupController
                                                    .isVisible.value = false;
                                              },
                                              icon:
                                                  const Icon(Icons.visibility))
                                          : IconButton(
                                              onPressed: () {
                                                signupController
                                                    .isVisible.value = true;
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
                            height: height * 0.04,
                          ),
                          Obx(() => RecButton(
                                name: "SignUp",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    signupController.isLoading.value != false
                                        ? () {}
                                        : signupController.signup();
                                  }
                                },
                                isLoading: signupController.isLoading.value,
                              )),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Get.offAllNamed(AppRoutes.getLoginRoute());
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: AppTheme.desaturatedBlue),
                              ),
                            ),
                          ),
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
    ;
  }
}
