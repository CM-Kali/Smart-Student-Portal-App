import 'package:flutter/material.dart';
import 'package:smart_student_portal/app/models/teacher_model.dart';
import 'package:smart_student_portal/app/utils/email_launcher.dart';

class TeacherDetailPage extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherDetailPage({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(teacher.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with photo
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  // Teacher Photo
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(teacher.photo),
                      onBackgroundImageError: (_, __) {},
                      child: teacher.photo.isEmpty
                          ? const Icon(Icons.person, size: 65)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Teacher Name
                  Text(
                    teacher.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subject
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      teacher.subject,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Introduction Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Introduction",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    teacher.introduction,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Contact Information
                  const Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Email Card
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: const Text("Email"),
                      subtitle: Text(teacher.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          EmailLauncher.openEmail(
                            email: teacher.email,
                            subject: 'Regarding ${teacher.subject}',
                            body:
                            'Hello ${teacher.name},\n\nI want to discuss about ${teacher.subject}.\n\nThanks.',
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Contact Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        EmailLauncher.openEmail(
                          email: teacher.email,
                          subject: 'Regarding ${teacher.subject}',
                          body:
                          'Hello ${teacher.name},\n\nI want to discuss about ${teacher.subject}.\n\nThanks.',
                        );
                      },
                      icon: const Icon(Icons.mail_outline),
                      label: const Text("Send Email"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}