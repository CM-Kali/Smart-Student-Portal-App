import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/timetable_model.dart';
import '../models/teacher_model.dart';

class TimetableController extends GetxController {
  RxList<TimetableModel> courses = <TimetableModel>[].obs;
  RxList<TeacherModel> teachers = <TeacherModel>[].obs;
  RxBool isLoading = true.obs;
  RxString selectedDay = 'All'.obs;

  final List<String> weekDays = [
    'All',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      // Load courses
      final String coursesResponse =
      await rootBundle.loadString('assets/data/courses.json');
      final List<dynamic> coursesData = jsonDecode(coursesResponse);
      courses.assignAll(
        coursesData.map((e) => TimetableModel.fromJson(e)).toList(),
      );

      // Load teachers
      final String teachersResponse =
      await rootBundle.loadString('assets/data/teachers.json');
      final List<dynamic> teachersData = jsonDecode(teachersResponse);
      teachers.assignAll(
        teachersData.map((e) => TeacherModel.fromJson(e)).toList(),
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to load timetable data");
      print("Timetable Load Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Get teacher by ID
  TeacherModel? getTeacherById(int id) {
    try {
      return teachers.firstWhere((teacher) => teacher.id == id.toString());
    } catch (e) {
      return null;
    }
  }

  // Get courses by day
  List<TimetableModel> getCoursesByDay(String day) {
    if (day == 'All') return courses;
    return courses.where((course) => course.schedule.day == day).toList();
  }

  // Get courses sorted by day
  Map<String, List<TimetableModel>> getCoursesByDayGrouped() {
    Map<String, List<TimetableModel>> grouped = {};
    for (var day in weekDays.skip(1)) {
      // Skip 'All'
      grouped[day] = courses
          .where((course) => course.schedule.day == day)
          .toList()
        ..sort((a, b) => a.schedule.time.compareTo(b.schedule.time));
    }
    return grouped;
  }
}