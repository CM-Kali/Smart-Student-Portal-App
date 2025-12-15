import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/course_model.dart';

class CoursesController extends GetxController {
  var courses = <CourseModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadCourses();
    super.onInit();
  }

  Future<void> loadCourses() async {
    final String response =
    await rootBundle.loadString('assets/data/courses.json');
    final List data = json.decode(response);
    courses.value = data.map((e) => CourseModel.fromJson(e)).toList();
    isLoading.value = false;
  }
}
