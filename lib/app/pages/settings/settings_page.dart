import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            const Text(
              "Appearance",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Obx(() => Card(
              child: SwitchListTile(
                title: const Text("Dark Mode"),
                subtitle: const Text("Enable dark theme"),
                secondary: const Icon(Icons.dark_mode),
                value: controller.isDarkMode.value,
                onChanged: (val) => controller.toggleTheme(),
              ),
            )),

            const SizedBox(height: 30),

            // Notifications Section
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Obx(() => Card(
              child: SwitchListTile(
                title: const Text("Notifications"),
                subtitle: const Text("Enable notifications"),
                secondary: const Icon(Icons.notifications),
                value: controller.notificationsEnabled.value,
                onChanged: (val) => controller.toggleNotifications(val),
              ),
            )),

            const SizedBox(height: 30),

            // Account Section
            const Text(
              "Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.lock, color: Colors.blue),
                title: const Text("Change Password"),
                subtitle: const Text("Update your password"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.snackbar(
                    "Coming Soon",
                    "This feature will be available soon",
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.privacy_tip, color: Colors.green),
                title: const Text("Privacy Policy"),
                subtitle: const Text("Read our privacy policy"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.snackbar(
                    "Privacy Policy",
                    "Opening privacy policy...",
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.info, color: Colors.orange),
                title: const Text("About"),
                subtitle: const Text("App version 1.0.0"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("About"),
                      content: const Text(
                        "Smart Student Portal\nVersion 1.0.0\n\n© 2025 All rights reserved",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Logout"),
                subtitle: const Text("Sign out of your account"),
                onTap: () => controller.logout(),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}