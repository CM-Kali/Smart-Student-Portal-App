import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/courses_controller.dart';

class CoursesPage extends StatelessWidget {
  CoursesPage({super.key});

  final CoursesController controller = Get.put(CoursesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Courses")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.courses.isEmpty) {
          return const Center(child: Text("No courses found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            final course = controller.courses[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("Code: ${course.code}"),
                    Text("Credits: ${course.creditHours}"),
                    Text("Semester: ${course.semester}"),
                    const SizedBox(height: 6),
                    Text(
                      course.description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(),
                    Text("📅 ${course.day}"),
                    Text("⏰ ${course.time}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
