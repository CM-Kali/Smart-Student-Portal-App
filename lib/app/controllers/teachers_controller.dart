import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/teacher_model.dart';

class TeachersController extends GetxController {
  var teachers = <TeacherModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    loadTeachers();
    super.onInit();
  }

  Future<void> loadTeachers() async {
    final String response =
    await rootBundle.loadString('assets/data/teachers.json');
    final List data = json.decode(response);
    teachers.value = data.map((e) => TeacherModel.fromJson(e)).toList();
    isLoading.value = false;
  }
}
