import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/course_model.dart';

class CoursesController extends GetxController {
  RxList<CourseModel> courses = <CourseModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      isLoading.value = true;

      final String response =
      await rootBundle.loadString('assets/data/courses.json');

      final List data = json.decode(response);

      courses.value =
          data.map((e) => CourseModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load courses");
      print("Course load error: $e");
    } finally {
      isLoading.value = false; // 🔴 THIS WAS MISSING LOGICALLY
    }
  }
}
