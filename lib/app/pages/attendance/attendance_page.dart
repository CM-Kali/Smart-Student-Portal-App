import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/attendance_controller.dart';

class AttendancePage extends StatelessWidget {
  AttendancePage({super.key});

  final AttendanceController controller =
  Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attendance: ${controller.attendancePercentage.toStringAsFixed(1)}%",
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: controller.attendancePercentage / 100,
                minHeight: 10,
              ),
              const SizedBox(height: 20),
              Text(
                "Status: ${controller.status}",
                style: TextStyle(
                  fontSize: 18,
                  color: controller.status == "Good"
                      ? Colors.green
                      : controller.status == "Warning"
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 30),

              // Buttons to test logic
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.attendedClasses.value++;
                    },
                    child: const Text("Mark Present"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      controller.attendedClasses.value--;
                    },
                    child: const Text("Mark Absent"),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
