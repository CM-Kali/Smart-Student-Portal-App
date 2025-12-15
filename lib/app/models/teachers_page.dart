import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_portal/app/models/teachers_controller.dart';

class TeachersPage extends StatelessWidget {
  TeachersPage({super.key});

  final TeachersController controller = Get.put(TeachersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teachers")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.teachers.length,
          itemBuilder: (context, index) {
            final teacher = controller.teachers[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(teacher.name),
                subtitle: Text(teacher.subject),
                trailing: IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () {},
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
