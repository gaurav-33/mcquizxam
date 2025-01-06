import 'package:get/get.dart';
import '../bindings/create_test_binding.dart';
import '../bindings/home_binding.dart';
import '../screens/auth/email_verification_screen.dart';
import '../screens/auth/forget_password_screen.dart';
import '../screens/create_test_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/test_analysis_screen.dart';
import '../screens/test_list_screen.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/test_screen.dart';

class AppRoutes {
  static String splash = "/splash";
  static String home = "/home";
  static String login = "/login";
  static String signup = "/signup";
  static String emailVerify = "/emailVerify";
  static String forgetPassword = "/forgetPassword";
  static String landingPage = "/landingPage";
  static String createTest = "/createTest";
  static String testListScreen = "/testList";
  static String testScreen = "/testScreen";
  static String testAnalysis = "/testAnalysis";

  static String getSplashRoute() => splash;

  static String getHomeRoute() => home;

  static String getLoginRoute() => login;

  static String getSignupRoute() => signup;

  static String getEmailVerifyRoute() => emailVerify;

  static String getForgetPasswordRoute() => forgetPassword;

  static String getLandingPageRoute() => landingPage;

  static String getCreateTestPageRoute() => createTest;

  static String getTestListRoute() => testListScreen;

  static String getTestRoute() => testScreen;

  static String getTestAnalysisRoute() => testAnalysis;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: emailVerify, page: () => EmailVerificationScreen()),
    GetPage(name: forgetPassword, page: () => ForgetPasswordScreen()),
    GetPage(name: landingPage, page: () => LandingScreen()),
    GetPage(
        name: createTest,
        page: () => CreateTestScreen(),
        binding: CreateTestBinding()),
    GetPage(name: landingPage, page: () => LandingScreen()),
    GetPage(
        name: testListScreen,
        page: () => TestListScreen(),
        binding: TestListBinding()),
    GetPage(name: testScreen, page: () => TestScreen(), binding: TestBinding()),
    GetPage(
        name: testAnalysis,
        page: () => TestAnalysisScreen(),
        binding: TestAnalysisBinding()),
  ];
}
