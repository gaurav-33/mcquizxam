import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

import '../res/theme.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _homeController = Get.find<HomeController>();
  final width = Get.width;
  final height = Get.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppTheme.desaturatedBlue,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            AppTheme.desaturatedBlue,
            AppTheme.darkIndigo,
          ], begin: Alignment.topRight, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: width * 0.05, horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                      fontSize: width * 0.07, color: AppTheme.darkIndigo),
                ),
                Obx(() => Text(_homeController.firstName.value,
                    style: TextStyle(
                        fontSize: width * 0.12, color: AppTheme.lightAqua))),
                Text(
                  "Learn, Grow, Succeed!",
                  style: TextStyle(
                      fontSize: width * 0.05, color: AppTheme.neptune100),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
