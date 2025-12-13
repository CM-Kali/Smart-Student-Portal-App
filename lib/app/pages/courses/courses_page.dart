import 'package:flutter/material.dart';
import 'course_card.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy courses list
    final courses = [
      {'name': 'App Dev', 'teacher': 'Mr. Uzair'},
      {'name': 'DSA', 'teacher': 'Mrs.MAjida '},
      {'name': 'WEB DEV', 'teacher': 'Mr. Husnain'},
      {'name': 'Biology', 'teacher': 'Mrs. Fatima'},
      {'name': 'Computer Science', 'teacher': 'Mr. Hammad'},
      {'name': 'English', 'teacher': 'Mrs. Raina'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: courses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseCard(
              courseName: course['name']!,
              teacherName: course['teacher']!,
            );
          },
        ),
      ),
    );
  }
}
