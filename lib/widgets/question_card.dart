import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../models/all_ques_model.dart';
import '../res/theme.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({
    super.key,
    required this.questionNumber,
    required this.questionModel,
    required this.onAnswerSelected,
    required this.controller, // Controller passed as a parameter
    this.correctOptionId,
  });

  final int questionNumber;
  final AllQuestionModel questionModel;
  final Function(int, String) onAnswerSelected;
  final dynamic
      controller; // Can be either TestController or TestAnalysisController
  final String? correctOptionId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        int selectedOption = -1;
        selectedOption = _getOptionIndex(controller.currentTest.value!
                .userAnswerMap[(questionNumber - 1).toString()] ??
            'X');
        return Card(
          color: AppTheme.neptune300,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question. no. $questionNumber",
                      style: const TextStyle(color: AppTheme.neptune900),
                    ),
                    Text(
                      "Id: ${questionModel.id}",
                      style: const TextStyle(color: AppTheme.neptune900),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                HtmlWidget(
                  questionModel.questionText,
                  textStyle: const TextStyle(
                      fontSize: 18), // Set the default text style
                ),
                const SizedBox(height: 15),
                ...List.generate(
                  4,
                  (index) => RadioListTile(
                    title: HtmlWidget(questionModel.options[index].text),
                    value: index,
                    groupValue: correctOptionId == null
                        ? selectedOption
                        : _getOptionIndex(correctOptionId!),
                    onChanged: (value) {
                      final String finalOption = _getOptionId(value!);
                      onAnswerSelected(questionNumber - 1, finalOption);
                    },
                    tileColor: correctOptionId != null
                        ? _getOptionIndex(correctOptionId!) == index
                            ? questionModel.options[index].isCorrect
                                ? AppTheme.lightGreen
                                : AppTheme.lightDanger
                            : questionModel.options[index].isCorrect
                                ? AppTheme.lightGreen
                                : Colors.transparent
                        : Colors.transparent,
                  ),
                ),
                const SizedBox(height: 5),
                correctOptionId == null
                    ? ElevatedButton.icon(
                        label: const Text(
                          "Reset",
                          style: TextStyle(color: AppTheme.neptune900),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.neptune400),
                        onPressed: () {
                          controller.resetAnswer(questionNumber - 1);
                        },
                        icon: const Icon(
                          Icons.restart_alt_rounded,
                          color: AppTheme.darkCharcoal,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                correctOptionId != null
                    ? const Text(
                        "Explanation:",
                        style: TextStyle(color: AppTheme.neptune900),
                      )
                    : const SizedBox(),
                const SizedBox(height: 15),
                correctOptionId != null
                    ? HtmlWidget(
                        questionModel.explanation!,
                        textStyle: const TextStyle(
                            fontSize: 18), // Set the default text style
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getOptionId(int index) {
    switch (index) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      default:
        return 'X';
    }
  }

  int _getOptionIndex(String optionId) {
    switch (optionId) {
      case 'A':
        return 0;
      case 'B':
        return 1;
      case 'C':
        return 2;
      case 'D':
        return 3;
      default:
        return -1;
    }
  }
}
