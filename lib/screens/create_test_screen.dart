import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/create_test_controller.dart';
import '../widgets/app_drawer.dart';
import '../widgets/drop_down_list.dart';
import '../widgets/named_horizontal_divider.dart';
import '../widgets/rec_button.dart';

import '../res/theme.dart';
import '../services/subject_topic_service.dart';

class CreateTestScreen extends StatelessWidget {
  CreateTestScreen({super.key});

  var height = Get.height;
  var width = Get.width;
  final CreateTestController createTestController =
      Get.find<CreateTestController>();


  final SubjectTopicService subjectTopicService =
      Get.find<SubjectTopicService>();

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
                    "Create Test",
                    style: TextStyle(fontSize: height * 0.035),
                  ),
                  const NamedHorizontalDivider(name: "Subject"),
                  Obx(() {
                    if (createTestController.subjectModelList.isEmpty) {
                      return const Text("Loading.....");
                    }
                    return DropDownList<String>(
                      items: createTestController.subjectModelList
                          .map((subject) => subject.name)
                          .toList(),
                      hint: "Select Subject",
                      value:
                          createTestController.selectedSubjectName.value.isEmpty
                              ? null
                              : createTestController.selectedSubjectName.value,
                      selectedItemId:
                          createTestController.subjectModelList.isEmpty
                              ? null
                              : createTestController.selectedSubjectId.value,
                      onChanged: (String? val) {
                        if (val != null) {
                          final selectedSubject = createTestController
                              .subjectModelList
                              .firstWhere((subject) => subject.name == val);
                          createTestController.selectedSubjectName.value = val;
                          createTestController.selectedSubjectId.value =
                              selectedSubject.id;
                          createTestController.selectedTopicName.value = "";
                          createTestController.selectedTopicId.value = "";
                          createTestController
                              .getTopicModelList(selectedSubject.id);
                        }
                      },
                    );
                  }),
                  const NamedHorizontalDivider(name: "Topic"),
                  Obx(
                    () {
                      if (createTestController.topicModelList.isEmpty) {
                        return const Text("Select subject first..");
                      }
                      return DropDownList<String>(
                          items: createTestController.topicModelList
                              .map((topic) => topic.name)
                              .toList(),
                          hint: "Select Topic",
                          value: createTestController.selectedTopicName.isEmpty
                              ? null
                              : createTestController.selectedTopicName.value,
                          selectedItemId:
                              createTestController.selectedTopicId.isEmpty
                                  ? null
                                  : createTestController.selectedTopicId.value,
                          onChanged: (String? val) {
                            if (val != null) {
                              final selectedTopic = createTestController
                                  .topicModelList
                                  .firstWhere((topic) => topic.name == val);
                              createTestController.selectedTopicId.value =
                                  selectedTopic.id;
                              createTestController.selectedTopicName.value =
                                  val;
                            }
                          });
                    },
                  ),
                  const NamedHorizontalDivider(name: "No. of Question"),
                  Obx(
                    () {
                      if (createTestController.testConfig.value == null) {
                        return const Text("Loading.....");
                      }
                      return DropDownList<int>(
                          items: createTestController
                              .testConfig.value!.questionCounts,
                          hint: "Select Question Count",
                          value: createTestController
                                      .selectedQuestionCount.value ==
                                  0
                              ? null
                              : createTestController
                                  .selectedQuestionCount.value,
                          selectedItemId: createTestController
                                      .selectedQuestionCount.value ==
                                  0
                              ? null
                              : createTestController.selectedQuestionCount.value
                                  .toString(),
                          onChanged: (int? val) {
                            if (val != null) {
                              createTestController.selectedQuestionCount.value =
                                  val;
                            }
                          });
                    },
                  ),
                  const NamedHorizontalDivider(name: "Mark(s) Each Question"),
                  Obx(() {
                    if (createTestController.testConfig.value == null) {
                      return const Text("Loading.....");
                    }
                    return DropDownList<double>(
                        items: createTestController
                            .testConfig.value!.marksPerQuestion,
                        hint: "Select Positive Mark(s)",
                        value: createTestController.selectedEachMark.value == 0
                            ? null
                            : createTestController.selectedEachMark.value,
                        selectedItemId:
                            createTestController.selectedEachMark.value == 0
                                ? null
                                : createTestController.selectedEachMark.value
                                    .toString(),
                        onChanged: (double? val) {
                          if (val != null) {
                            createTestController.selectedEachMark.value = val;
                          }
                        });
                  }),
                  const NamedHorizontalDivider(
                      name: "Negative Mark(s) Each Question"),
                  Obx(() {
                    if (createTestController.testConfig.value == null) {
                      return const Text("Loading.....");
                    }
                    return DropDownList<double>(
                        items: createTestController
                            .testConfig.value!.negativeMarks,
                        hint: "Select Negative Mark(s)",
                        value: createTestController
                                    .selectedNegativeMark.value ==
                                1.0
                            ? null
                            : createTestController.selectedNegativeMark.value,
                        selectedItemId: createTestController
                                    .selectedNegativeMark.value ==
                                1.0
                            ? null
                            : createTestController.selectedNegativeMark.value
                                .toString(),
                        onChanged: (double? val) {
                          if (val != null) {
                            createTestController.selectedNegativeMark.value =
                                val;
                          }
                        });
                  }),
                  const NamedHorizontalDivider(name: "Duration"),
                  Obx(() {
                    if (createTestController.testConfig.value == null) {
                      return const Text("Loading.....");
                    }
                    return DropDownList<double>(
                        items: createTestController.testConfig.value!.durations,
                        hint: "Select Test Duration",
                        value:
                            createTestController.selectedDuration.value == 0.0
                                ? null
                                : createTestController.selectedDuration.value,
                        selectedItemId:
                            createTestController.selectedDuration.value == 0.0
                                ? null
                                : createTestController.selectedDuration.value
                                    .toString(),
                        onChanged: (double? val) {
                          if (val != null) {
                            createTestController.selectedDuration.value = val;
                          }
                        });
                  }),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.center,
                      child: Obx(() => RecButton(
                          name: "Create Now",
                          onTap: () async {
                            await createTestController.submit();
                          },
                          isLoading: createTestController.isLoading.value)))
                ],
              ),
            ),
          ),
        ));
  }
}
