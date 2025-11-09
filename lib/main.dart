import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizller/app/controllers/auth/auth_controller.dart';
import 'package:quizller/app/routes/app_pages.dart';
import 'package:quizller/app/core/theme/app_theme.dart';
import 'package:quizller/app/controllers/themes/theme_controller.dart';
import 'app/controllers/auth/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // only potrait mode 
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // firebase initalization 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // dependency injection 
  Get.put(AuthController());
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.SPLASHSCREEN,
    );
  }
}
