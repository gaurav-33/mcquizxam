import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/test_analysis_controller.dart';
import '../routes/app_routes.dart';

import '../models/all_ques_model.dart';
import '../res/theme.dart';
import '../widgets/question_card.dart';
import '../widgets/rec_button.dart';

class TestAnalysisScreen extends StatelessWidget {
  TestAnalysisScreen({super.key});

  final double height = Get.height;
  final double width = Get.width;
  final TestAnalysisController testAnalysisController =
      Get.find<TestAnalysisController>();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (testAnalysisController.currentTest.value == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final List<AllQuestionModel> questionList =
        testAnalysisController.allQuestionList;
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
                      "Test Analysis",
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
                        Text(
                          "${(testAnalysisController.currentTest.value!.durationLeft / 60).toInt()}m ${(testAnalysisController.currentTest.value!.durationLeft % 60).toInt()}s / ${(testAnalysisController.currentTest.value!.duration / 60).toInt()}m ${(testAnalysisController.currentTest.value!.duration % 60).toInt()}s",
                          style: const TextStyle(
                              color: AppTheme.lightAqua, fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attempt: ${testAnalysisController.currentTest.value?.questionAnswered} / ${testAnalysisController.currentTest.value?.numberOfQuestions}",
                          style: headerTextStyle,
                        ),
                        Text(
                          "Full Marks: ${testAnalysisController.currentTest.value?.totalMarks}",
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
                        Text(
                          "Correct: ${testAnalysisController.currentTest.value?.correctAnswers}",
                          style: headerTextStyle,
                        ),
                        Text(
                          "Wrong: ${testAnalysisController.currentTest.value?.incorrectAnswers}",
                          style: headerTextStyle,
                        ),
                        Text(
                          "Skip: ${testAnalysisController.currentTest.value!.numberOfQuestions - testAnalysisController.currentTest.value!.questionAnswered}",
                          style: headerTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.check, color: AppTheme.lightAqua),
                            Text(
                              " +${testAnalysisController.currentTest.value?.marksPerQuestion}",
                              style: headerTextStyle,
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.close, color: AppTheme.lightAqua),
                            Text(
                              " ${testAnalysisController.currentTest.value?.negativeMarksPerQuestion}",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Score:',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: AppTheme.neptune200,
                            )),
                        Text(
                            '${(testAnalysisController.currentTest.value!.totalScore / testAnalysisController.currentTest.value!.totalMarks * 100).toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: AppTheme.neptune200,
                            )),
                        RichText(
                          text: TextSpan(
                            text:
                                '${testAnalysisController.currentTest.value!.totalScore}',
                            style: TextStyle(
                              fontSize: width *
                                  0.09, // Larger font size for totalScore
                              fontWeight: FontWeight.bold,
                              color: AppTheme.neptune200,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    ' / ${testAnalysisController.currentTest.value!.totalMarks}',
                                style: TextStyle(
                                  fontSize: width * 0.06,
                                  fontWeight: FontWeight.normal,
                                  color: AppTheme.darkIndigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildScoreBar(),
                    const SizedBox(
                      height: 10,
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
                            testAnalysisController.currentPageIndex.value =
                                index;
                          },
                          itemBuilder: (context, index) {
                            return QuestionCard(
                              questionModel: questionList[index],
                              questionNumber: index + 1,
                              onAnswerSelected: (int, String) {},
                              correctOptionId: testAnalysisController
                                  .currentTest
                                  .value!
                                  .userAnswerMap[index.toString()],
                              controller: testAnalysisController,
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
                              if (testAnalysisController
                                      .currentPageIndex.value >
                                  0) {
                                testAnalysisController.currentPageIndex.value--;
                                _pageController.jumpToPage(
                                    testAnalysisController
                                        .currentPageIndex.value);
                              }
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        RecButton(
                          name: "Back",
                          onTap: () {
                            Get.offNamed(AppRoutes.getTestListRoute());
                          },
                          width: width * 0.32,
                          isLoading: false,
                        ),
                        IconButton.outlined(
                            onPressed: () {
                              if (testAnalysisController
                                      .currentPageIndex.value <
                                  testAnalysisController
                                          .allQuestionList.length -
                                      1) {
                                testAnalysisController.currentPageIndex.value++;
                                _pageController.jumpToPage(
                                    testAnalysisController
                                        .currentPageIndex.value);
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

  Widget _buildScoreBar() {
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
          height: height * 0.005,
          decoration: BoxDecoration(
              color: AppTheme.darkCharcoal,
              borderRadius: BorderRadius.circular(30)),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
          height: height * 0.005,
          width: width *
                      (testAnalysisController.currentTest.value?.totalMarks ??
                          1) ==
                  0
              ? 0
              : (testAnalysisController.currentTest.value!.totalScore /
                  testAnalysisController.currentTest.value!.totalMarks),
          decoration: BoxDecoration(
              color: AppTheme.neptune200,
              borderRadius: BorderRadius.circular(30)),
        ),
      ],
    );
  }

  void _buildOptionTile() {
    // Prevent duplicate BottomSheets
    if (Get.isBottomSheetOpen ?? false) return;

    Get.bottomSheet(
      elevation: 4,
      backgroundColor: AppTheme.neptune400,
      isDismissible: true,
      enableDrag: true,
      persistent: true,
      Column(
        children: [
          const SizedBox(height: 15),
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
                testAnalysisController.currentTest.value!.numberOfQuestions,
                (index) {
                  return RecButton(
                    name: (index + 1).toString(),
                    fontSize: 16,
                    onTap: () {
                      testAnalysisController.currentPageIndex.value = index;
                      _pageController.jumpToPage(
                        testAnalysisController.currentPageIndex.value,
                      );
                      if (Get.isSnackbarOpen) {
                        Get.closeCurrentSnackbar();
                      }
                      Get.back(); // Close BottomSheet
                    },
                    isLoading: false,
                    width: width * 0.006,
                    buttonColor: testAnalysisController.currentTest.value!
                                .originalAnswerMap[index.toString()] ==
                            testAnalysisController.currentTest.value!
                                .userAnswerMap[index.toString()]
                        ? AppTheme.darkGreen
                        : AppTheme.darkDanger,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
