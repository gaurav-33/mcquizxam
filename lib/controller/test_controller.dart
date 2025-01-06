import 'dart:async';

import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../models/all_ques_model.dart';
import '../models/mock_test_model.dart';
import '../services/all_question_service.dart';
import '../services/mock_test_services.dart';
import '../shared_preference/mock_test_preferences.dart';
import '../utils/toast_snack_bar.dart';

class TestController extends GetxController {
  // Observables
  Rx<MockTestModel?> currentTest = Rx<MockTestModel?>(null);
  RxMap<int, int> selectedOptions = <int, int>{}.obs;
  RxString currentAnswer = ''.obs;
  RxBool isSubmitting = false.obs;
  RxInt currentPageIndex = 0.obs;
  final RxList<AllQuestionModel> allQuestionList = <AllQuestionModel>[].obs;

  Timer? _timer;

  // Dependencies
  final MockTestPreferences _mockTestPreferences;
  final HomeController _homeController;
  final MockTestServices _mockTestServices;
  final AllQuestionService _allQuestionService;

  TestController({
    required MockTestPreferences mockTestPreferences,
    required HomeController homeController,
    required MockTestServices mockTestServices,
    required AllQuestionService allQuestionService,
  })  : _mockTestPreferences = mockTestPreferences,
        _homeController = homeController,
        _mockTestServices = mockTestServices,
        _allQuestionService = allQuestionService;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null && Get.arguments['mockTestModel'] != null) {
      currentTest.value = Get.arguments['mockTestModel'] as MockTestModel;
    } else {
      AppSnackBar.error("Failed to load test data.");
      return;
    }
    await _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      await loadAllQuestions();
      await initialiseTest();
      _startTimer();
    } catch (e) {
      AppSnackBar.error("Initialization error: ${e.toString()}");
    }
  }

  Future<void> initialiseTest() async {
    if (currentTest.value?.status == "ongoing") return;

    try {
      final answeredQuestions = {
        for (int i = 0; i < currentTest.value!.numberOfQuestions; i++)
          i.toString(): 'X'
      };
      currentTest.value = currentTest.value?.copyWith(
        userAnswerMap: answeredQuestions,
        status: "ongoing",
      );
      await _mockTestPreferences.saveMockTest(
        currentTest.value!,
        currentTest.value!.id,
      );
    } catch (e) {
      AppSnackBar.error("Failed to initialize test: ${e.toString()}");
    }
  }

  Future<void> loadAllQuestions() async {
    if (currentTest.value == null) {
      AppSnackBar.error("Failed to load questions: Test is not initialized.");
      return;
    }
    try {
      allQuestionList.value = await _allQuestionService.fetchAllQuestion(
        _homeController.uid.value,
        currentTest.value!.id,
      );
    } catch (e) {
      AppSnackBar.error("Error loading questions: ${e.toString()}");
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTest.value == null || currentTest.value!.durationLeft <= 0) {
        _timer?.cancel();
        submitTest();
      } else {
        currentTest.value = currentTest.value!.copyWith(
          durationLeft: currentTest.value!.durationLeft - 1,
        );
        _mockTestPreferences.saveMockTest(
          currentTest.value!,
          currentTest.value!.id,
        );
      }
    });
  }

  void answerQuestion(int questionIndex, String optionId) {
    if (currentTest.value == null) return;

    currentTest.value!.userAnswerMap[questionIndex.toString()] = optionId;
    currentTest.value = currentTest.value!.copyWith(
      currentQuestionIndex: questionIndex + 1,
    );
    _mockTestPreferences.saveMockTest(
      currentTest.value!,
      currentTest.value!.id,
    );
  }

  void resetAnswer(int questionIndex) {
    if (currentTest.value == null) return;

    currentTest.value!.userAnswerMap[questionIndex.toString()] = 'X';
    currentTest.value = currentTest.value!.copyWith(
      currentQuestionIndex: questionIndex,
    );
    update();
  }

  Future<void> submitTest() async {
    if (isSubmitting.value) return;
    isSubmitting.value = true;

    try {
      _timer?.cancel();
      evaluate();
      if (currentTest.value != null) {
        await _attemptSubmitTest();
        AppSnackBar.success("Test submitted successfully!");
        Get.find<MockTestPreferences>().deleteMockTest(currentTest.value!.id);
      }
    } catch (e) {
      AppSnackBar.error("Failed to submit test: ${e.toString()}");
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> _attemptSubmitTest() async {
    const int maxRetries = 3;
    const Duration retryDelay = Duration(seconds: 3);

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        currentTest.value = currentTest.value?.copyWith(status: "completed");
        await _mockTestServices.uploadMockTest(
          _homeController.uid.value,
          currentTest.value!.id,
          currentTest.value!,
        );
        return;
      } catch (e) {
        if (attempt == maxRetries - 1) rethrow;
        await Future.delayed(retryDelay * (attempt + 1));
      }
    }
  }

  void evaluate() {
    if (currentTest.value == null) return;

    final originalAnswerMap = _generateOriginalAnswerMap();
    int correctCount = 0, incorrectCount = 0;
    double totalPositiveMarks = 0, totalNegativeMarks = 0;
    final double positive = currentTest.value!.marksPerQuestion;
    final double negative = currentTest.value!.negativeMarksPerQuestion;

    currentTest.value!.userAnswerMap.forEach((key, value) {
      if (originalAnswerMap[key] == value) {
        correctCount++;
        totalPositiveMarks += positive;
      } else if (value != 'X') {
        incorrectCount++;
        totalNegativeMarks -= negative;
      }
    });

    currentTest.value = currentTest.value?.copyWith(
      correctAnswers: correctCount,
      incorrectAnswers: incorrectCount,
      questionAnswered: correctCount + incorrectCount,
      totalScore: totalPositiveMarks + totalNegativeMarks,
      originalAnswerMap: originalAnswerMap,
    );
  }

  Map<String, String> _generateOriginalAnswerMap() {
    final originalAnswerMap = <String, String>{};
    for (int index = 0; index < allQuestionList.length; index++) {
      final correctOption = allQuestionList[index]
          .options
          .firstWhereOrNull((option) => option.isCorrect);
      if (correctOption != null) {
        originalAnswerMap[index.toString()] = correctOption.optionId;
      }
    }
    return originalAnswerMap;
  }

  void pauseTimer() => _timer?.cancel();

  void resumeTimer() => _startTimer();

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
