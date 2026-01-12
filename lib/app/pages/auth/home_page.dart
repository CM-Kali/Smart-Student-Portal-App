import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Student Smart Portal',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('students')
                              .doc(currentUser?.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.exists) {
                              final studentData = snapshot.data!.data() as Map<String, dynamic>?;
                              final studentName = studentData?['name'] ?? 'Student';
                              return Text(
                                '$studentName 👋',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              );
                            }
                            return const Text(
                              'Student 👋',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Dashboard Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _dashboardCard('Courses', Icons.book, Colors.blue, () {
                    Get.to(() => CoursesPage());
                  }),
                  _dashboardCard('Teachers', Icons.person, Colors.purple, () {
                    Get.to(() => TeachersPage());
                  }),
                  _dashboardCard('Timetable', Icons.schedule, Colors.orange, () {
                    Get.to(() => TimetablePage());
                  }),
                  _dashboardCard('Attendance', Icons.check_circle, Colors.green, () {
                    Get.to(() => AttendancePage());
                  }),
                  _dashboardCard('Assignments', Icons.assignment, Colors.red, () {
                    Get.to(() => AssignmentsPage());
                  }),
                  _dashboardCard('Profile', Icons.account_circle, Colors.teal, () {
                    Get.to(() => ProfilePage());
                  }),
                  _dashboardCard('Settings', Icons.settings, Colors.indigo, () {
                    Get.to(() => SettingsPage());
                  }),
                  _dashboardCard('Chatbot', Icons.smart_toy, Colors.cyan, () {
                    Get.to(() => ChatbotPage());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black26,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
                child: Icon(icon, size: 36, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}