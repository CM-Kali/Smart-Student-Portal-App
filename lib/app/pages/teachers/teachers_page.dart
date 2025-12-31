import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_portal/app/controllers/teachers_controller.dart';
import 'package:smart_student_portal/app/utils/email_launcher.dart';

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
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, color: Colors.blue),
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
                trailing: IconButton(
                  icon: const Icon(Icons.email, color: Colors.blue),
                  onPressed: () {
                    EmailLauncher.openEmail(
                      email: teacher.email,
                      subject: 'Regarding ${teacher.subject}',
                      body:
                      'Hello ${teacher.name},\n\nI want to discuss about ${teacher.subject}.\n\nThanks.',
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
