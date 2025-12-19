import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

void main() {
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
      themeMode: ThemeMode.light, // default
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => SplashPage()),
        GetPage(name: AppRoutes.login, page: () => LoginPage()),
        GetPage(name: AppRoutes.signup, page: () => SignupPage()),
        GetPage(name: AppRoutes.forgot, page: () => ForgotPage()),
        GetPage(name: AppRoutes.home, page: () => HomePage()),

        GetPage(name: AppRoutes.courses, page: () => CoursesPage()),
        GetPage(name: AppRoutes.teachers, page: () => TeachersPage()),
        GetPage(name: AppRoutes.timetable, page: () => TimetablePage()),
        GetPage(name: AppRoutes.attendance, page: () => AttendancePage()),
        GetPage(name: AppRoutes.assignments, page: () => AssignmentsPage()),
        GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
        GetPage(name: AppRoutes.settings, page: () => SettingsPage()),
        GetPage(name: AppRoutes.chatbot, page: () => ChatbotPage()),
      ],
    );

  }
}
