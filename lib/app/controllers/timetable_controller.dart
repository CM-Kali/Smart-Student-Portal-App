import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/timetable_model.dart';
import '../models/teacher_model.dart';

class TimetableController extends GetxController {

  /// List of all courses
  final RxList<TimetableModel> courses = <TimetableModel>[].obs;

  /// List of all teachers
  final RxList<TeacherModel> teachers = <TeacherModel>[].obs;

  /// Loading indicator
  final RxBool isLoading = true.obs;

  /// Selected day for filtering
  final RxString selectedDay = 'All'.obs;

  /// Days of the week (reactive)
  final RxList<String> weekDays = <String>[
    'All',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }


  Future<void> loadData() async {
    try {
      isLoading.value = true;

      // Load courses JSON
      final String coursesResponse =
      await rootBundle.loadString('assets/data/courses.json');
      final List<dynamic> coursesData = jsonDecode(coursesResponse);

      courses.assignAll(
        coursesData.map((e) => TimetableModel.fromJson(e)).toList(),
      );

      // Load teachers JSON
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

  /// ================================
  /// BUSINESS LOGIC
  /// ================================

  /// Get teacher by ID safely
  TeacherModel? getTeacherById(int id) {
    try {
      return teachers.firstWhere((teacher) => teacher.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get courses filtered by selected day
  List<TimetableModel> getCoursesByDay(String day) {
    if (day == 'All') return courses;
    return courses.where((course) => course.schedule.day == day).toList();
  }

  /// Get courses grouped by day (useful for full timetable)
  Map<String, List<TimetableModel>> getCoursesByDayGrouped() {
    Map<String, List<TimetableModel>> grouped = {};
    for (var day in weekDays.skip(1)) {
      // Skip "All"
      grouped[day] = courses
          .where((course) => course.schedule.day == day)
          .toList()
        ..sort((a, b) => a.schedule.time.compareTo(b.schedule.time));
    }
    return grouped;
  }



  /// Check if courses list is empty
  bool get isEmpty => courses.isEmpty;

  /// Total courses count
  int get totalCourses => courses.length;

  /// Set selected day
  void setSelectedDay(String day) {
    selectedDay.value = day;
  }
}
