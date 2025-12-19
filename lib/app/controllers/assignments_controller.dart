import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../models/assignment_model.dart';

class AssignmentsController extends GetxController {
  var assignments = <AssignmentModel>[
    AssignmentModel(title: "AI Assignment", dueDate: "20 Sep"),
    AssignmentModel(title: "Flutter Lab", dueDate: "22 Sep"),
    AssignmentModel(title: "SE Quiz", dueDate: "25 Sep"),
  ].obs;

  Future<void> submitAssignment(int index) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      assignments[index].isSubmitted = true;
      assignments[index].fileName = result.files.single.name;
      assignments.refresh();
    }
  }
}
