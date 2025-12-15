import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/courses_controller.dart';

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

        return ListView.builder(
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            final course = controller.courses[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(course.name),
                subtitle: Text("Instructor: ${course.instructor}"),
                trailing: Text("${course.credits} Cr"),
              ),
            );
          },
        );
      }),
    );
  }
}
