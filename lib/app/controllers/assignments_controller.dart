import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class AssignmentsController extends GetxController {
  var selectedFileName = ''.obs;

  Future<void> submitAssignment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      selectedFileName.value = result.files.single.name;
      Get.snackbar("Success", "File Selected: ${selectedFileName.value}");
    } else {
      Get.snackbar("Cancelled", "No file selected");
    }
  }
}
