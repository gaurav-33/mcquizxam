import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/theme.dart';

class TestCard extends StatelessWidget {
  TestCard(
      {super.key,
      required this.testSubject,
      required this.testTopic,
      required this.totalTime,
      required this.leftTime,
      required this.totalQuestion,
      required this.leftQuestion,
      required this.onTap,
      required this.testIndex});

  var height = Get.height;
  var width = Get.width;
  final String testSubject;
  final String testTopic;
  final double totalTime;
  final double leftTime;
  final String totalQuestion;
  final String leftQuestion;
  final VoidCallback onTap;
  final int testIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Container(
          height: height * 0.21,
          width: width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: const LinearGradient(colors: [
                AppTheme.darkCharcoal,
                AppTheme.neptune600,
                AppTheme.darkCharcoal
              ], begin: Alignment.topRight, end: Alignment.bottomRight)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  testIndex.toString(),
                  style:
                      const TextStyle(fontSize: 28, color: AppTheme.lightAqua),
                ),
                Text(
                  testSubject,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.lightAqua),
                ),
                Text(
                  testTopic,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.lightAqua),
                ),
                Text(
                  "Total Q. $totalQuestion",
                  style:
                      const TextStyle(fontSize: 12, color: AppTheme.lightAqua),
                ),
                Text(
                  "Left Q. $leftQuestion",
                  style:
                      const TextStyle(fontSize: 12, color: AppTheme.lightAqua),
                ),
                Text(
                  "Total: ${(totalTime / 60).toInt()} m ${(totalTime % 60).toInt()} s",
                  style:
                      const TextStyle(fontSize: 12, color: AppTheme.lightAqua),
                ),
                Text(
                  "Left: ${(leftTime / 60).toInt()} m ${(leftTime % 60).toInt()} s",
                  style:
                      const TextStyle(fontSize: 12, color: AppTheme.lightAqua),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
