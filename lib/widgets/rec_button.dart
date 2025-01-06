import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/theme.dart';

class RecButton extends StatelessWidget {
  const RecButton(
      {super.key,
      required this.name,
      required this.onTap,
      this.height,
      this.width,
      required this.isLoading,
      this.fontSize,
      this.buttonColor});

  final String name;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final bool isLoading;
  final double? fontSize;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppTheme.desaturatedBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        fixedSize: Size(
          width ?? Get.width * 0.5,
          height ?? Get.width * 0.12,
        ),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: AppTheme.lightAqua,
                backgroundColor: AppTheme.desaturatedCyan,
              )
            : Text(
                name,
                style: TextStyle(
                    fontSize: fontSize ?? 26, color: AppTheme.lightAqua),
              ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   return InkWell(
//     onTap: onTap,
//     child: Container(
//         width: width ?? Get.width * 0.5,
//         height: height ?? Get.width * 0.12,
//         decoration: const BoxDecoration(
//             color: AppTheme.desaturatedBlue,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24),
//                 bottomRight: Radius.circular(24))),
//         child: Center(
//           child: isLoading
//               ? const CircularProgressIndicator(
//             color: AppTheme.lightAqua,
//           )
//               : Text(
//             name,
//             style: const TextStyle(fontSize: 26, color: AppTheme.lightAqua),
//           ),
//         )),
//   );
// }
