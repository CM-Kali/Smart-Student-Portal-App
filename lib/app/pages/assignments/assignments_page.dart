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
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.assignments.length,
          itemBuilder: (context, index) {
            final assignment = controller.assignments[index];

            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(assignment.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Due: ${assignment.dueDate}"),
                    if (assignment.fileName != null)
                      Text("File: ${assignment.fileName}",
                          style: const TextStyle(fontSize: 12)),
                  ],
                ),
                trailing: assignment.isSubmitted
                    ? const Chip(
                  label: Text("Submitted"),
                  backgroundColor: Colors.green,
                )
                    : ElevatedButton(
                  onPressed: () {
                    controller.submitAssignment(index);
                  },
                  child: const Text("Submit"),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
