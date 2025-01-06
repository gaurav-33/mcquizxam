import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../utils/toast_snack_bar.dart';
import '../widgets/menu_tile.dart';

import '../controller/home_controller.dart';
import '../res/theme.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final height = Get.height;
  final width = Get.width;
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.neptune200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * .33,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: [AppTheme.desaturatedBlue, AppTheme.darkCharcoal],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight)),
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    CircleAvatar(
                      radius: width * 0.15,
                      backgroundColor: AppTheme.desaturatedCyan,
                      child: Icon(
                        Icons.person,
                        size: width * 0.15,
                        color: AppTheme.veryLightBlue,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${_homeController.firstName.value} ${_homeController.lastName.value}",
                      style: TextStyle(
                          color: AppTheme.lightAqua,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _homeController.email.value,
                      style: TextStyle(
                          color: AppTheme.lightAqua, fontSize: width * 0.03),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
              child: Text(
            "Menu",
            style: TextStyle(color: AppTheme.desaturatedBlue, fontSize: 18),
          )),
          MenuTile(
            name: "Dashboard",
            icon: Icon(
              Icons.dashboard,
              color: AppTheme.darkCharcoal,
            ),
            onTap: () {
              Get.offNamed(AppRoutes.getHomeRoute());
            },
          ),
          MenuTile(
            name: "Tests",
            icon: Icon(
              Icons.paste_rounded,
              color: AppTheme.darkCharcoal,
            ),
            onTap: () {
              Get.offNamed(AppRoutes.getTestListRoute());
            },
          ),
          const MenuTile(
              name: "Settings",
              icon: Icon(
                Icons.settings_rounded,
                color: AppTheme.darkCharcoal,
              )),
          const MenuTile(
              name: "Privacy and Security",
              icon: Icon(
                Icons.privacy_tip_rounded,
                color: AppTheme.darkCharcoal,
              )),
          const MenuTile(
              name: "Contact Us",
              icon: Icon(
                Icons.contact_support_rounded,
                color: AppTheme.darkCharcoal,
              )),
          MenuTile(
            name: "Logout",
            icon: const Icon(
              Icons.logout_rounded,
              color: AppTheme.darkDanger,
            ),
            onTap: () async {
              await _homeController.auth.signOut();
              AppSnackBar.success("Logout Successfully.");
              Get.offAllNamed(AppRoutes.getLoginRoute());
            },
          ),
        ],
      ),
    );
  }
}
