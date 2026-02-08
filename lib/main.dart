import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/controllers/auth_controller.dart';
import 'app/pages/assignments/assignments_page.dart';
import 'app/pages/attendance/attendance_page.dart';
import 'app/pages/auth/forgot_page.dart';
import 'app/pages/auth/home_page.dart';
import 'app/pages/auth/login_page.dart';
import 'app/pages/auth/signup_page.dart';
import 'app/pages/chatbot/chatbot_page.dart';
import 'app/pages/courses/courses_page.dart';
import 'app/pages/profile/profile_page.dart';
import 'app/pages/settings/settings_page.dart';
import 'app/pages/splash/splash_page.dart';
import 'app/pages/teachers/teachers_page.dart';
import 'app/pages/timetable/timetable_page.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize GetStorage
  await GetStorage.init();

  // Put AuthController as permanent
  Get.put(AuthController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
        GetPage(name: AppRoutes.login, page: () =>  LoginPage()),
        GetPage(name: AppRoutes.signup, page: () =>  SignUpPage()),
        GetPage(name: AppRoutes.forgot, page: () =>  ForgotPage()),
        GetPage(name: AppRoutes.home, page: () => const HomePage()),
        GetPage(name: AppRoutes.courses, page: () =>  CoursesPage()),
        GetPage(name: AppRoutes.teachers, page: () =>  TeachersPage()),
        GetPage(name: AppRoutes.timetable, page: () =>  TimetablePage()),
        GetPage(name: AppRoutes.attendance, page: () => const AttendancePage()),
        GetPage(name: AppRoutes.assignments, page: () =>  AssignmentsPage()),
        GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
        GetPage(name: AppRoutes.settings, page: () =>  SettingsPage()),
        GetPage(name: AppRoutes.chatbot, page: () =>  ChatbotPage()),
      ],
    );
  }
}
