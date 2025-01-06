import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../controller/test_analysis_controller.dart';
import '../controller/test_list_controller.dart';
import '../services/all_question_service.dart';
import '../services/firestore_ref_service.dart';
import '../shared_preference/mock_test_preferences.dart';
import '../controller/create_test_controller.dart';
import '../controller/test_controller.dart';
import '../services/create_test_service.dart';
import '../services/mock_test_services.dart';
import '../services/random_question_service.dart';
import '../services/subject_topic_service.dart';
import '../services/test_config_service.dart';
import '../shared_preference/subject_topic_preferences.dart';
import '../shared_preference/test_config_preferences.dart';

class TestListBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<FirestoreRefService>()) {
      Get.put(FirestoreRefService());
    }
    Get.put(MockTestServices());
    Get.put(TestListController());
  }
}

class CreateTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubjectTopicPreferences());
    Get.put(TestConfigPreferences());
    Get.put(SubjectTopicService());
    Get.put(TestConfigService());
    Get.put(RandomQuestionService());
    Get.put(CreateTestService());
    Get.put(CreateTestController());
  }
}

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MockTestPreferences());
    Get.put(AllQuestionService());
    Get.put(TestController(
      mockTestPreferences: Get.find<MockTestPreferences>(),
      homeController: Get.find<HomeController>(),
      mockTestServices: Get.find<MockTestServices>(),
      allQuestionService: Get.find<AllQuestionService>(),
    ));
  }
}

class TestAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MockTestPreferences());
    Get.put(AllQuestionService());
    Get.put(TestAnalysisController(
      mockTestPreferences: Get.find<MockTestPreferences>(),
      homeController: Get.find<HomeController>(),
      mockTestServices: Get.find<MockTestServices>(),
      allQuestionService: Get.find<AllQuestionService>(),
    ));
  }
}
