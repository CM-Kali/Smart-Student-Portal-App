import 'package:flutter/material.dart';
import '../../models/assignment_model.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AssignmentModel> assignments = [
      AssignmentModel(
        title: "AI Lab Report",
        subject: "Artificial Intelligence",
        dueDate: "20 Dec 2025",
        isSubmitted: false,
      ),
      AssignmentModel(
        title: "Flutter App",
        subject: "App Development",
        dueDate: "22 Dec 2025",
        isSubmitted: true,
      ),
      AssignmentModel(
        title: "Web Project",
        subject: "Web Development",
        dueDate: "25 Dec 2025",
        isSubmitted: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(assignment.title),
              subtitle: Text(
                  "${assignment.subject}\nDue: ${assignment.dueDate}"),
              isThreeLine: true,
              trailing: Chip(
                label: Text(
                  assignment.isSubmitted ? "Submitted" : "Pending",
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: assignment.isSubmitted
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
