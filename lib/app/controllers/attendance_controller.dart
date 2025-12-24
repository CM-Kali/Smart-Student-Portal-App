import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Map<String, dynamic>> attendanceList = <Map<String, dynamic>>[].obs;

  final List<String> subjects = [
    "App Dev",
    "Web Dev",
    "AI Lab",
    "AI Theory",
    "Computer Networks",
    "Computer Networks Lab",
    "Technical Writing",
    "Community Service"
  ];

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
  }

  // Initialize attendance for student with prefilled values
  Future<void> initializeAttendanceIfEmpty(String uid) async {
    try {
      DocumentSnapshot doc = await firestore.collection('students').doc(uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        if (!data.containsKey('attendance') || (data['attendance'] as List).isEmpty) {
          List<Map<String, dynamic>> initialAttendance = [
            {"subject": "Web Dev", "present": 13, "total": 15},
            {"subject": "AI Lab", "present": 10, "total": 12},
            {"subject": "AI Theory", "present": 11, "total": 12},
            {"subject": "Computer Networks", "present": 9, "total": 10},
            {"subject": "Computer Networks Lab", "present": 8, "total": 10},
            {"subject": "Technical Writing", "present": 14, "total": 15},
            {"subject": "Community Service", "present": 1, "total": 1},
          ];

          await firestore.collection('students').doc(uid).update({
            "attendance": initialAttendance,
          });
        }
      }
    } catch (e) {
      print("Error initializing attendance: $e");
    }
  }

  // Fetch attendance from Firestore
  void fetchAttendance() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await initializeAttendanceIfEmpty(uid);

      DocumentSnapshot doc = await firestore.collection('students').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('attendance')) {
          attendanceList.value = List<Map<String, dynamic>>.from(data['attendance']);
        }
      }
    } catch (e) {
      print("Error fetching attendance: $e");
    }
  }

  // Calculate percentage (0-100)
  double getPercentage(int attended, int total) {
    if (total == 0) return 0.0;
    double percent = (attended / total) * 100;
    return percent.clamp(0, 100);
  }

  // Status based on percentage
  String getStatus(double percent) {
    if (percent >= 75) return "Good";
    if (percent >= 60) return "Warning";
    return "Low";
  }
}
