import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../courses/courses_page.dart';
import '../teachers/teachers_page.dart';
import '../timetable/timetable_page.dart';
import '../attendance/attendance_page.dart';
import '../assignments/assignments_page.dart';
import '../profile/profile_page.dart';
import '../settings/settings_page.dart';
import '../chatbot/chatbot_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Smart Portal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Student 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _dashboardCard('Courses', Icons.book, () {
                    Get.to(() => const CoursesPage());
                  }),
                  _dashboardCard('Teachers', Icons.person, () {
                    Get.to(() => const TeachersPage());
                  }),
                  _dashboardCard('Timetable', Icons.schedule, () {
                    Get.to(() => const TimetablePage());
                  }),
                  _dashboardCard('Attendance', Icons.check_circle, () {
                    Get.to(() => const AttendancePage());
                  }),
                  _dashboardCard('Assignments', Icons.assignment, () {
                    Get.to(() => const AssignmentsPage());
                  }),
                  _dashboardCard('Profile', Icons.account_circle, () {
                    Get.to(() => const ProfilePage());
                  }),
                  _dashboardCard('Settings', Icons.settings, () {
                    Get.to(() => const SettingsPage());
                  }),
                  _dashboardCard('Chatbot', Icons.smart_toy, () {
                    Get.to(() => const ChatbotPage());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 42),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
