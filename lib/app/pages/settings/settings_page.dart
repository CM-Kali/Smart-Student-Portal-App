import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: darkMode,
            onChanged: (val) {
              setState(() {
                darkMode = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text("Notifications"),
            value: notifications,
            onChanged: (val) {
              setState(() {
                notifications = val;
              });
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About App"),
            subtitle: const Text("Smart Student Portal v1.0"),
            onTap: () {
              Get.defaultDialog(
                title: "About",
                middleText:
                "Smart Student Portal\nDeveloped by CMADEEL\nBSCS Project",
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Get.offAllNamed(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}
