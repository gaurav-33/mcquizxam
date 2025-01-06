import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/test_controller.dart';
import '../models/all_ques_model.dart';
import '../widgets/question_card.dart';
import '../widgets/rec_button.dart';

import '../res/theme.dart';
import '../routes/app_routes.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});

  final double height = Get.height;
  final double width = Get.width;

  final TestController testController = Get.find<TestController>();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (testController.currentTest.value == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<AllQuestionModel> questionList = testController.allQuestionList;
    return Scaffold(
      body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            AppTheme.desaturatedBlue,
            AppTheme.darkIndigo,
          ], begin: Alignment.topRight, end: Alignment.bottomRight)),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.035),
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
                      "Good Luck",
                      style: TextStyle(fontSize: height * 0.035),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: AppTheme.lightAqua,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(() {
                          return Text(
                            "${(testController.currentTest.value!.durationLeft / 60).toInt()}m ${(testController.currentTest.value!.durationLeft % 60).toInt()}s / ${(testController.currentTest.value!.duration / 60).toInt()}m ${(testController.currentTest.value!.duration % 60).toInt()}s",
                            style: const TextStyle(
                                color: AppTheme.lightAqua, fontSize: 20),
                          );
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Ques.: ${testController.currentTest.value?.numberOfQuestions}",
                          style: headerTextStyle,
                        ),
                        Text(
                          "Full Marks: ${testController.currentTest.value?.totalMarks}",
                          style: headerTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.check, color: AppTheme.lightAqua),
                            Text(
                              " +${testController.currentTest.value?.marksPerQuestion}",
                              style: headerTextStyle,
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.close, color: AppTheme.lightAqua),
                            Text(
                              " ${testController.currentTest.value?.negativeMarksPerQuestion}",
                              style: headerTextStyle,
                            ),
                          ],
                        ),
                        IconButton.outlined(
                            onPressed: () {
                              _buildOptionTile();
                            },
                            icon: const Icon(Icons.grid_view_rounded,
                                color: AppTheme.lightAqua)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(child: Obx(() {
                      if (questionList.isEmpty) {
                        return const Center(
                            child: Text("No questions available right now..."));
                      }
                      return PageView.builder(
                          controller: _pageController,
                          itemCount: questionList.length,
                          onPageChanged: (index) {
                            testController.currentPageIndex.value = index;
                          },
                          itemBuilder: (context, index) {
                            return QuestionCard(
                              questionModel: questionList[index],
                              onAnswerSelected: (index, optionId) {
                                testController.answerQuestion(index, optionId);
                              },
                              questionNumber: index + 1,
                              controller: testController,
                            );
                          });
                    })),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton.outlined(
                            onPressed: () {
                              if (testController.currentPageIndex.value > 0) {
                                testController.currentPageIndex.value--;
                                _pageController.jumpToPage(
                                    testController.currentPageIndex.value);
                              }
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        RecButton(
                          name: "Submit",
                          onTap: () {
                            testController.submitTest();
                            Get.offNamed(AppRoutes.getTestListRoute());
                          },
                          isLoading: testController.isSubmitting.value,
                          width: width * 0.32,
                        ),
                        IconButton.outlined(
                            onPressed: () {
                              if (testController.currentPageIndex.value <
                                  testController.allQuestionList.length - 1) {
                                testController.currentPageIndex.value++;
                                _pageController.jumpToPage(
                                    testController.currentPageIndex.value);
                              }
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    )
                  ]))),
    );
  }

  TextStyle headerTextStyle =
      const TextStyle(color: AppTheme.lightAqua, fontSize: 17);

  _buildOptionTile() {
    // Prevent duplicate BottomSheets
    if (Get.isBottomSheetOpen!) return;

    return Get.bottomSheet(
      elevation: 4,
      backgroundColor: AppTheme.neptune400,
      isDismissible: true,
      enableDrag: true,
      persistent: true,
      Column(children: [
        const SizedBox(
          height: 15,
        ),
        IconButton.outlined(
          onPressed: () {
            if (Get.isSnackbarOpen) {
              Get.closeCurrentSnackbar(); // Close any active snackbar
            }
            if (Navigator.canPop(Get.context!)) {
              Get.back(); // Close BottomSheet
            }
          },
          icon: const Icon(
            Icons.close_rounded,
            color: AppTheme.darkDanger,
          ),
        ),
        Expanded(
          child: GridView.count(
              padding: const EdgeInsets.all(14),
              crossAxisCount: 5,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              children: List.generate(
                  testController.currentTest.value!.numberOfQuestions, (index) {
                return Obx(() {
                  return RecButton(
                    name: (index + 1).toString(),
                    fontSize: 16,
                    onTap: () {
                      testController.currentPageIndex.value = index;
                      _pageController
                          .jumpToPage(testController.currentPageIndex.value);
                      if (Get.isSnackbarOpen) {
                        Get.closeCurrentSnackbar();
                      }
                      Get.back(); // Close BottomSheet
                    },
                    isLoading: false,
                    width: width * 0.006,
                    buttonColor: testController.currentTest.value!
                                .userAnswerMap[index.toString()] ==
                            'X'
                        ? AppTheme.darkDanger
                        : AppTheme.darkGreen,
                  );
                });
              })),
        ),
      ]),
    );
  }
}
