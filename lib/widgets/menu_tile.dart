import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/theme.dart';

class MenuTile extends StatelessWidget {
  const MenuTile(
      {super.key, required this.name, required this.icon, this.onTap});

  final String name;
  final Icon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Card(
          color: AppTheme.lightAqua,
          child: ListTile(
            leading: icon,
            title: Text(
              name,
              style: TextStyle(
                  color: name == "Logout"
                      ? AppTheme.darkDanger
                      : AppTheme.desaturatedBlue,
                  fontSize: Get.width * 0.04),
            ),
            onTap: onTap,
          ),
        ));
  }
}
