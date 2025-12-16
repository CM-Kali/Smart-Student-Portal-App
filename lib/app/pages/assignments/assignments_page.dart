import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/assignments_controller.dart';

class AssignmentsPage extends StatelessWidget {
  AssignmentsPage({super.key});

  final AssignmentsController controller =
  Get.put(AssignmentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AI Assignment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Obx(() => Text(
              controller.selectedFileName.isEmpty
                  ? "No file selected"
                  : "Selected: ${controller.selectedFileName.value}",
            )),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Submit Assignment"),
              onPressed: () {
                controller.submitAssignment();
              },
            ),
          ],
        ),
      ),
    );
  }
}
