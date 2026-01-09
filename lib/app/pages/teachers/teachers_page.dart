import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_portal/app/controllers/teachers_controller.dart';
import 'package:smart_student_portal/app/pages/teachers/teacher_detail_page.dart'; // Add this import

class TeachersPage extends StatelessWidget {
  TeachersPage({super.key});

  final TeachersController controller = Get.put(TeachersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.teachers.isEmpty) {
          return const Center(child: Text("No teachers found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.teachers.length,
          itemBuilder: (context, index) {
            final teacher = controller.teachers[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                // Update leading to show actual photo
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(teacher.photo),
                  onBackgroundImageError: (_, __) {},
                  child: teacher.photo.isEmpty
                      ? const Icon(Icons.person, color: Colors.blue)
                      : null,
                ),
                title: Text(
                  teacher.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  teacher.subject,
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                // Add onTap to navigate to detail page
                onTap: () {
                  Get.to(() => TeacherDetailPage(teacher: teacher));
                },
              ),
            );
          },
        );
      }),
    );
  }
}