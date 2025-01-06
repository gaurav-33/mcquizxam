import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';
import '../res/theme.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  SplashScreen({super.key});
  final String imagePath = "assets/logo_mcquiz.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.desaturatedBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage(imagePath),
                  height: 500,
                ),
                ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 15,
                          sigmaY: 20,
                        ),
                        child: Image(
                          image: AssetImage(imagePath),
                          height: 500,
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
