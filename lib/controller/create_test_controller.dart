import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../controller/test_list_controller.dart';
import '../models/all_ques_model.dart';
import '../models/mock_test_model.dart';
import '../models/subject_model.dart';
import '../routes/app_routes.dart';
import '../services/create_test_service.dart';
import '../services/random_question_service.dart';
import '../services/subject_topic_service.dart';
import '../services/test_config_service.dart';
import '../shared_preference/subject_topic_preferences.dart';
import '../shared_preference/test_config_preferences.dart';
import '../utils/toast_snack_bar.dart';

import '../models/test_config_model.dart';

class CreateTestController extends GetxController {
  RxList<SubjectModel> subjectModelList = <SubjectModel>[].obs;
  RxString selectedSubjectName = "".obs;
  RxString selectedSubjectId = "".obs;

  RxList<TopicModel> topicModelList = <TopicModel>[].obs;
  RxString selectedTopicName = "".obs;
  RxString selectedTopicId = "".obs;

  Rxn<TestConfigModel> testConfig = Rxn<TestConfigModel>();
  RxDouble selectedDuration = 0.0.obs;
  RxDouble selectedEachMark = 0.0.obs;
  RxDouble selectedNegativeMark = 1.0.obs;
  RxInt selectedQuestionCount = 0.obs;

  RxBool isLoading = false.obs;

  late final SubjectTopicService _subjectTopicService;
  late final TestConfigService _testConfigService;
  late final RandomQuestionService _randomQuestionService;
  late final HomeController _homeController;
  late final CreateTestService _createTestService;
  late final TestListController _testListController;

  @override
  void onInit() {
    super.onInit();
    initializeAll();
  }

  Future<void> initializeAll() async {
    _subjectTopicService = Get.find<SubjectTopicService>();
    _testConfigService = Get.find<TestConfigService>();
    _randomQuestionService = Get.find<RandomQuestionService>();
    _homeController = Get.find<HomeController>();
    _createTestService = Get.find<CreateTestService>();
    _testListController = Get.find<TestListController>();
    getSubjectModelList();
    getTestConfig();
  }

  Future<void> getSubjectModelList() async {
    try {
      await SubjectTopicPreferences.deleteSubjectList();
      List<SubjectModel> savedSubjectModelList =
          await SubjectTopicPreferences.getSubjectList();
      if (savedSubjectModelList.isEmpty) {
        savedSubjectModelList = await _subjectTopicService.fetchSubjectList();
        await SubjectTopicPreferences.saveSubjectList(savedSubjectModelList);
      }
      subjectModelList.value = savedSubjectModelList;
    } catch (e) {
      AppSnackBar.error(e.toString());
      subjectModelList.value = [];
    }
  }

  Future<void> getTopicModelList(String subjectId) async {
    try {
      await SubjectTopicPreferences.deleteTopicList(subjectId);
      List<TopicModel> savedTopicModelList =
          await SubjectTopicPreferences.getTopicList(subjectId);
      if (savedTopicModelList.isEmpty) {
        savedTopicModelList =
            await _subjectTopicService.fetchTopicList(subjectId);
        await SubjectTopicPreferences.saveTopicList(
            savedTopicModelList, subjectId);
      }
      topicModelList.value = savedTopicModelList;
    } catch (e) {
      AppSnackBar.error(e.toString());
      topicModelList.value = [];
    }
  }

  Future<void> getTestConfig() async {
    try {
      await TestConfigPreferences.deleteTestConfig();
      TestConfigModel? savedTestConfig =
          await TestConfigPreferences.getTestConfig();
      if (savedTestConfig == null) {
        savedTestConfig = await _testConfigService.fetchTestConfig();
        await TestConfigPreferences.saveTestConfig(savedTestConfig!);
      }
      testConfig.value = savedTestConfig;
    } catch (e) {
      AppSnackBar.error(e.toString());
      testConfig.value = null;
    }
  }

  Future<void> submit() async {
    try {
      isLoading.value = true;
      List<AllQuestionModel> questionList = [];
      if (await checkAllFields()) {
        questionList = await _randomQuestionService.getRandomQuestion(
            selectedSubjectId.value,
            selectedTopicId.value,
            selectedQuestionCount.value);

        MockTestModel mockTestModel = MockTestModel(
            title: "${selectedSubjectName.value} Test",
            id: '',
            subject: selectedSubjectName.value,
            topic: selectedTopicName.value,
            description:
                "Test for ${selectedSubjectName.value} and from this ${selectedTopicName.value} Topic",
            duration: selectedDuration.value.toDouble() * 60,
            durationLeft: selectedDuration.value.toDouble() * 60,
            totalMarks: selectedQuestionCount.value * selectedEachMark.value,
            negativeMarksPerQuestion: selectedNegativeMark.value,
            status: "incomplete",
            numberOfQuestions: selectedQuestionCount.value,
            marksPerQuestion: selectedEachMark.value,
            questionAnswered: 0,
            correctAnswers: 0,
            incorrectAnswers: 0,
            totalScore: 0,
            currentQuestionIndex: 0,
            userAnswerMap: {},
            originalAnswerMap: {},
            updatedAt: DateTime.now());
        if (questionList.isNotEmpty) {
          String mockTestId = await _createTestService.createTest(
              _homeController.uid.value, questionList, mockTestModel);
          Get.toNamed(AppRoutes.getTestListRoute());
        }
        isLoading.value = false;
        await _testListController.loadAllTests();
      } else {
        AppSnackBar.error("Select all fields.");
        isLoading.value = false;
      }
    } catch (e) {
      AppSnackBar.error(e.toString());
      isLoading.value = false;
    }
  }

  Future<bool> checkAllFields() async {
    bool isChecked = false;
    isChecked = selectedSubjectId.value.isEmpty ? false : true;
    isChecked = selectedTopicId.value.isEmpty ? false : true;
    isChecked = selectedQuestionCount.value == 0 ? false : true;
    isChecked = selectedEachMark.value == 0 ? false : true;
    isChecked = selectedNegativeMark.value == 1 ? false : true;
    isChecked = selectedDuration.value == 0.0 ? false : true;

    return isChecked;
  }
}
