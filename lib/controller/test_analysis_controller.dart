import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../services/all_question_service.dart';

import '../models/all_ques_model.dart';
import '../models/mock_test_model.dart';
import '../services/mock_test_services.dart';
import '../shared_preference/mock_test_preferences.dart';
import '../utils/toast_snack_bar.dart';

class TestAnalysisController extends GetxController {
  Rx<MockTestModel?> currentTest = Rx<MockTestModel?>(null);

  // var selectedOptions = <int, int>{}.obs;
  final RxList<AllQuestionModel> allQuestionList = <AllQuestionModel>[].obs;
  Map<int, bool?> userResponseMap = {};
  RxInt currentPageIndex = 0.obs;

  late final MockTestPreferences _mockTestPreferences;
  late final HomeController _homeController;
  late final MockTestServices _mockTestServices;
  late final AllQuestionService _allQuestionService;

  TestAnalysisController({
    required MockTestPreferences mockTestPreferences,
    required HomeController homeController,
    required MockTestServices mockTestServices,
    required AllQuestionService allQuestionService,
  }) {
    _mockTestPreferences = mockTestPreferences;
    _homeController = homeController;
    _mockTestServices = mockTestServices;
    _allQuestionService = allQuestionService;
  }

  @override
  void onInit() {
    super.onInit();
    // Retrieve mockTestModel from Get.arguments
    if (Get.arguments != null && Get.arguments["mockTestModel"] != null) {
      currentTest.value = Get.arguments["mockTestModel"] as MockTestModel;
    } else {
      AppSnackBar.error("Failed to load test data.");
    }
    loadAllQuestions();
  }

  Future<void> loadAllQuestions() async {
    if (Get.arguments != null && Get.arguments["allQuestionList"] != null) {
      allQuestionList.value =
          Get.arguments["allQuestionList"] as List<AllQuestionModel>;
      return;
    }

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
}
