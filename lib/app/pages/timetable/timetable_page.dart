import 'package:flutter/material.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final timetable = [
      {"day": "Monday", "subject": "AI"},
      {"day": "Tuesday", "subject": "Web Dev"},
      {"day": "Wednesday", "subject": "App Dev"},
      {"day": "Thursday", "subject": "CN"},
      {"day": "Friday", "subject": "English"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Timetable")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: timetable.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final item = timetable[index];
          return Card(
            elevation: 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['day']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['subject']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
