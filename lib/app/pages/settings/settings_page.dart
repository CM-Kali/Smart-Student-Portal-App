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
        elevation: 2,
      ),
      body: Obx(
            () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Appearance",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Dark Mode Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 18),
                  ),
                  secondary: const Icon(Icons.dark_mode),
                  value: controller.isDarkMode.value,
                  onChanged: (val) => controller.toggleTheme(),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Logout Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    // Logout logic
                    Get.offAllNamed('/login');
                  },
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Other Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Example: Notification Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                  title: const Text(
                    "Notifications",
                    style: TextStyle(fontSize: 18),
                  ),
                  secondary: const Icon(Icons.notifications),
                  value: true, // dummy, you can control later
                  onChanged: (val) {},
                ),
              ),

              const SizedBox(height: 50), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}
