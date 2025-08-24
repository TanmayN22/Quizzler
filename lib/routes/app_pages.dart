// pages routes

import 'package:get/get.dart';
import 'package:quizller/controllers/auth.dart';
import 'package:quizller/controllers/login_or_register.dart';
import 'package:quizller/views/courses_screen.dart';
import 'package:quizller/views/login_screen.dart';
import 'package:quizller/views/sigin_screen.dart';
import 'package:quizller/views/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.SPLASHSCREEN, page: () => const SplashScreen()),
    GetPage(name: Routes.SIGNIN, page: () => const SigninScreen()),
    GetPage(name: Routes.LOGIN, page: () => const LoginScreen()),
    GetPage(name: Routes.LOGINORSIGNIN, page: () => const LoginOrRegister()),
    GetPage(name: Routes.AUTHPAGE, page: () => const AuthPage()),
    GetPage(name: Routes.COURSES, page: () => const CoursesScreen()),
  ];
}
