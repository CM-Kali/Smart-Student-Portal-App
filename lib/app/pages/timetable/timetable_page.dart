import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_portal/app/controllers/timetable_controller.dart';
import 'package:smart_student_portal/app/pages/teachers/teacher_detail_page.dart';

class TimetablePage extends StatelessWidget {
  TimetablePage({super.key});

  final TimetableController controller = Get.put(TimetableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Day Filter - Only this part is reactive
          _buildDayFilter(),

          // Course List - Only this part is reactive
          Expanded(
            child: _buildCourseList(context),
          ),
        ],
      ),
    );
  }

  // Separate reactive widget for day filter
  Widget _buildDayFilter() {
    return SizedBox(
      height: 60,
      child: Obx(() {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: controller.weekDays.length,
          itemBuilder: (context, index) {
            final day = controller.weekDays[index];
            final isSelected = controller.selectedDay.value == day;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    controller.selectedDay.value = day;
                  }
                },
                selectedColor: Colors.blue,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // Separate reactive widget for course list
  Widget _buildCourseList(BuildContext context) {
    return Obx(() {
      // Loading state
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Empty state
      if (controller.courses.isEmpty) {
        return const Center(child: Text("No courses found"));
      }

      final filteredCourses =
      controller.getCoursesByDay(controller.selectedDay.value);

      // No classes for selected day
      if (filteredCourses.isEmpty) {
        return _buildEmptyState();
      }

      // Course list
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredCourses.length,
        itemBuilder: (context, index) {
          final course = filteredCourses[index];
          final teacher = controller.getTeacherById(course.teacherId);
          return _buildCourseCard(context, course, teacher);
        },
      );
    });
  }

  // Non-reactive empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
      Text(
        "No classes on ${controller.selectedDay.value}",
        style: TextStyle(fontSize: 18, color: Colors.grey[600]),

          ),
        ],
      ),
    );
  }

  // Non-reactive course card widget
  Widget _buildCourseCard(BuildContext context, course, teacher) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _showCourseDetails(context, course, teacher);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Time Badge
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time,
                              size: 16, color: Colors.blue.shade700),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              course.schedule.time,
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Credit Hours
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${course.creditHours} CH",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Course Title
              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              // Course Code
              Text(
                course.code,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // Teacher Info
              if (teacher != null)
                InkWell(
                  onTap: () {
                    Get.to(() => TeacherDetailPage(teacher: teacher));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(teacher.photo),
                        onBackgroundImageError: (_, __) {},
                        child: teacher.photo.isEmpty
                            ? const Icon(Icons.person, size: 18)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              teacher.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              teacher.email,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 14, color: Colors.grey[400]),
                    ],
                  ),
                ),

              // Day Badge (only show when "All" is selected)
              Obx(() {
                if (controller.selectedDay.value == 'All') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        course.schedule.day,
                        style: TextStyle(
                          color: Colors.purple.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showCourseDetails(BuildContext context, course, teacher) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Title
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.code,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Info Cards
                    _buildInfoCard(
                      icon: Icons.access_time,
                      title: "Schedule",
                      value: "${course.schedule.day} • ${course.schedule.time}",
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.school,
                      title: "Credit Hours",
                      value: "${course.creditHours} CH",
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.bookmark,
                      title: "Semester",
                      value: course.semester,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 20),

                    // Description
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Teacher Section
                    if (teacher != null) ...[
                      const Text(
                        "Instructor",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(teacher.photo),
                            onBackgroundImageError: (_, __) {},
                            child: teacher.photo.isEmpty
                                ? const Icon(Icons.person)
                                : null,
                          ),
                          title: Text(
                            teacher.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(teacher.email),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => TeacherDetailPage(teacher: teacher));
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}