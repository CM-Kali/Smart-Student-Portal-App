import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/teacher_model.dart';

class TeachersController extends GetxController {
  RxList<TeacherModel> teachers = <TeacherModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadTeachers();
  }

  Future<void> loadTeachers() async {
    try {
      final String response =
      await rootBundle.loadString('assets/data/teachers.json');

      final List<dynamic> data = jsonDecode(response);

      teachers.assignAll(
        data.map((e) => TeacherModel.fromJson(e)).toList(),
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to load teachers");
      print("Teachers Load Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
