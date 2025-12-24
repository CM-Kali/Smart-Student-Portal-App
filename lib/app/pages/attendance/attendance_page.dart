import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final AttendanceController controller = Get.put(AttendanceController());

  @override
  void initState() {
    super.initState();
    controller.fetchAttendance(); // fetch from Firestore only once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.attendanceList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.attendanceList.length,
            itemBuilder: (context, index) {
              var item = controller.attendanceList[index];
              String subject = item['subject'] ?? '';
              int present = item['present'] ?? 0;
              int total = item['total'] ?? 0;
              double percent = controller.getPercentage(present, total);
              String status = controller.getStatus(percent);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: total == 0 ? 0 : percent / 100,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        color: percent >= 75
                            ? Colors.green
                            : percent >= 60
                            ? Colors.orange
                            : Colors.red,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(total == 0
                              ? "No classes yet"
                              : "Present: $present / $total"),
                          Text(
                            status,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: percent >= 75
                                  ? Colors.green
                                  : percent >= 60
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
