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
      body: Obx(() => ListView.builder(
        itemCount: controller.assignments.length,
        itemBuilder: (context, index) {
          final assignment = controller.assignments[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(assignment.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Due: ${assignment.dueDate}"),
                  Text(
                    assignment.isSubmitted
                        ? "Status: Submitted"
                        : "Status: Pending",
                    style: TextStyle(
                      color: assignment.isSubmitted
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              trailing: assignment.isSubmitted
                  ? const Icon(Icons.check, color: Colors.green)
                  : ElevatedButton(
                onPressed: () {
                  controller.submitAssignment(index);
                },
                child: const Text("Submit"),
              ),
            ),
          );
        },
      )),
    );
  }
}
