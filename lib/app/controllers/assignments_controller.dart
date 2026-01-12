import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../models/assignment_model.dart';

class AssignmentsController extends GetxController {
  var assignments = <AssignmentModel>[
    AssignmentModel(
      id: "1",
      title: "Machine Learning Project",
      subject: "Artificial Intelligence",
      dueDate: "25 Jan",
      description: "Build a neural network model for image classification",
      marks: 20,
    ),
    AssignmentModel(
      id: "2",
      title: "Flutter App Development",
      subject: "App Development",
      dueDate: "28 Jan",
      description: "Create a fully functional mobile application using Flutter",
      marks: 30,
    ),
    AssignmentModel(
      id: "3",
      title: "Network Protocol Analysis",
      subject: "Computer Networks",
      dueDate: "30 Jan",
      description: "Analyze TCP/IP protocols and create a detailed report",
      marks: 15,
    ),
    AssignmentModel(
      id: "4",
      title: "Web Application",
      subject: "Web Development",
      dueDate: "15 Jan",
      description: "Develop a responsive web application with React",
      marks: 25,
      isSubmitted: true,
      fileName: "web_project.zip",
      submittedDate: "14 Jan",
    ),
  ].obs;

  var selectedFilter = "All".obs;

  // Make filters observable
  final filters = ["All", "Pending", "Submitted", "Overdue"];

  List<AssignmentModel> get filteredAssignments {
    switch (selectedFilter.value) {
      case "Pending":
        return assignments.where((a) => !a.isSubmitted && !a.isOverdue).toList();
      case "Submitted":
        return assignments.where((a) => a.isSubmitted).toList();
      case "Overdue":
        return assignments.where((a) => a.isOverdue).toList();
      default:
        return assignments;
    }
  }

  int get pendingCount => assignments.where((a) => !a.isSubmitted && !a.isOverdue).length;
  int get submittedCount => assignments.where((a) => a.isSubmitted).length;
  int get overdueCount => assignments.where((a) => a.isOverdue).length;

  Future<void> submitAssignment(int index) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'zip'],
      );

      if (result != null) {
        assignments[index].isSubmitted = true;
        assignments[index].fileName = result.files.single.name;
        assignments[index].submittedDate = "${DateTime.now().day} ${_getMonthName(DateTime.now().month)}";
        assignments.refresh();

        Get.snackbar(
          "Success",
          "Assignment submitted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to submit assignment",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  void showAssignmentDetails(AssignmentModel assignment) {
    Get.dialog(
      AlertDialog(
        title: Text(assignment.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow("Subject", assignment.subject),
              _buildDetailRow("Due Date", assignment.dueDate),
              _buildDetailRow("Marks", "${assignment.marks}"),
              const SizedBox(height: 10),
              const Text(
                "Description:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(assignment.description),
              if (assignment.isSubmitted) ...[
                const SizedBox(height: 10),
                _buildDetailRow("Submitted File", assignment.fileName ?? ""),
                _buildDetailRow("Submitted On", assignment.submittedDate ?? ""),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}