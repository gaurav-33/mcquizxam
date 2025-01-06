import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/test_list_controller.dart';
import '../models/mock_test_model.dart';
import '../services/mock_test_services.dart';
import '../widgets/app_drawer.dart';
import '../widgets/named_horizontal_divider.dart';
import '../widgets/rec_button.dart';
import '../widgets/test_card.dart';

import '../res/theme.dart';
import '../routes/app_routes.dart';

class TestListScreen extends StatelessWidget {
  TestListScreen({super.key});

  var height = Get.height;
  var width = Get.width;
  final TestListController testListController = Get.find<TestListController>();

  final MockTestServices mockTestServices = Get.find<MockTestServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.desaturatedBlue,
        ),
        drawer: AppDrawer(),
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            AppTheme.desaturatedBlue,
            AppTheme.darkIndigo,
          ], begin: Alignment.topRight, end: Alignment.bottomRight)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                    "Tests List",
                    style: TextStyle(fontSize: height * 0.035),
                  ),
                  RecButton(
                      name: "Create Test",
                      onTap: () async {
                        Get.offNamed(
                          AppRoutes.getCreateTestPageRoute(),
                        );
                      },
                      isLoading: false),
                  const NamedHorizontalDivider(name: "Resume Tests"),
                  Obx(() {
                    if (testListController.isLoading.value) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Consider using localized strings.
                      );
                    } else if (testListController.resumeMockTestList.isEmpty) {
                      return const Center(
                        child: Text(
                            "No tests available to resume."), // Handle empty state.
                      );
                    } else {
                      return SizedBox(
                          height: height * 0.21,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  testListController.resumeMockTestList.length,
                              itemBuilder: (context, index) {
                                MockTestModel mockTest = testListController
                                    .resumeMockTestList[index];
                                return TestCard(
                                  onTap: () {
                                    Get.offNamed(AppRoutes.getTestRoute(),
                                        arguments: {"mockTestModel": mockTest});
                                  },
                                  testIndex: testListController
                                          .resumeMockTestList.length -
                                      index,
                                  testSubject: mockTest.subject,
                                  testTopic: mockTest.topic,
                                  totalTime: mockTest.duration,
                                  leftTime: mockTest.durationLeft,
                                  totalQuestion:
                                      mockTest.numberOfQuestions.toString(),
                                  leftQuestion: (mockTest.numberOfQuestions -
                                          mockTest.questionAnswered)
                                      .toString(),
                                );
                              }));
                    }
                  }),
                  const NamedHorizontalDivider(name: "Present Tests"),
                  Obx(() {
                    if (testListController.isLoading.value) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Consider using localized strings.
                      );
                    } else if (testListController.presentMockTestList.isEmpty) {
                      return const Center(
                        child: Text("No Present Test."), // Handle empty state.
                      );
                    } else {
                      return SizedBox(
                          height: height * 0.21,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  testListController.presentMockTestList.length,
                              itemBuilder: (context, index) {
                                MockTestModel mockTest = testListController
                                    .presentMockTestList[index];
                                return TestCard(
                                  onTap: () {
                                    Get.offNamed(AppRoutes.getTestRoute(),
                                        arguments: {"mockTestModel": mockTest});
                                  },
                                  testIndex: testListController
                                          .presentMockTestList.length -
                                      index,
                                  testSubject: mockTest.subject,
                                  testTopic: mockTest.topic,
                                  totalTime: mockTest.duration,
                                  leftTime: mockTest.durationLeft,
                                  totalQuestion:
                                      mockTest.numberOfQuestions.toString(),
                                  leftQuestion: (mockTest.numberOfQuestions -
                                          mockTest.questionAnswered)
                                      .toString(),
                                );
                              }));
                    }
                  }),
                  const NamedHorizontalDivider(name: "Previous Tests"),
                  Obx(() {
                    if (testListController.isLoading.value) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Consider using localized strings.
                      );
                    } else if (testListController
                        .previousMockTestList.isEmpty) {
                      return const Center(
                        child: Text("No Previous Test."), // Handle empty state.
                      );
                    } else {
                      return SizedBox(
                        height: height * 0.45,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: List.generate(
                              testListController.previousMockTestList.length,
                              (index) {
                            MockTestModel mockTest =
                                testListController.previousMockTestList[index];
                            return TestCard(
                              onTap: () {
                                Get.toNamed(AppRoutes.getTestAnalysisRoute(),
                                    arguments: {"mockTestModel": mockTest});
                              },
                              testIndex: testListController
                                      .previousMockTestList.length -
                                  index,
                              testSubject: mockTest.subject,
                              testTopic: mockTest.topic,
                              totalTime: mockTest.duration,
                              leftTime: mockTest.durationLeft,
                              totalQuestion:
                                  mockTest.numberOfQuestions.toString(),
                              leftQuestion: (mockTest.numberOfQuestions -
                                      mockTest.questionAnswered)
                                  .toString(),
                            );
                          }),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
