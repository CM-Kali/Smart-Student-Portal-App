import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 60),
            ),
            const SizedBox(height: 16),
            const Text(
              "CMADEEL",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("BSCS - Semester 5"),
            const Divider(height: 30),

            _infoTile("Roll No", "BSCS-21-001"),
            _infoTile("Department", "Computer Science"),
            _infoTile("Email", "cmadeel@student.edu.pk"),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
