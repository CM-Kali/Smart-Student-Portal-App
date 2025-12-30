import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Obx(() {
        if (controller.student.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.pickAndUploadImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: controller.student['profile_pic'] != null &&
                          controller.student['profile_pic'] != ''
                          ? MemoryImage(
                          base64Decode(controller.student['profile_pic']))
                          : null,
                      child: controller.student['profile_pic'] == null ||
                          controller.student['profile_pic'] == ''
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                    if (controller.loading.value)
                      const Positioned.fill(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Text(
                controller.student['name'] ?? '',
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(controller.student['email'] ?? ''),
              const SizedBox(height: 20),

              _infoTile("Roll No", controller.student['roll_no']),
              _infoTile("Semester", controller.student['semester']),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoTile(String title, String value) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
