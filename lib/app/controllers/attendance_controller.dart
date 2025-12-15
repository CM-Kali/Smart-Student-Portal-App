import 'package:get/get.dart';

class AttendanceController extends GetxController {
  var totalClasses = 40.obs;
  var attendedClasses = 30.obs;

  double get attendancePercentage =>
      (attendedClasses.value / totalClasses.value) * 100;

  String get status {
    if (attendancePercentage >= 75) return "Good";
    if (attendancePercentage >= 60) return "Warning";
    return "Low";
  }
}
