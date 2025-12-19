import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../models/assignment_model.dart';

class AssignmentsController extends GetxController {
  var assignments = <AssignmentModel>[
    AssignmentModel(title: "AI Assignment", dueDate: "20 Sep"),
    AssignmentModel(title: "Flutter Project", dueDate: "25 Sep"),
  ].obs;

  Future<void> submitAssignment(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      assignments[index].filePath = result.files.single.path;
      assignments[index].isSubmitted = true;
      assignments.refresh();
    }
  }
}
