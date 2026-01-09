class TimetableModel {
  final String id;
  final String title;
  final String code;
  final int creditHours;
  final String semester;
  final int teacherId;
  final String description;
  final Schedule schedule;

  TimetableModel({
    required this.id,
    required this.title,
    required this.code,
    required this.creditHours,
    required this.semester,
    required this.teacherId,
    required this.description,
    required this.schedule,
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    // SAFE parsing with defaults
    return TimetableModel(
      id: json['id']?.toString() ?? '0',
      title: json['title']?.toString() ?? 'No Title',
      code: json['code']?.toString() ?? 'NOCode',
      creditHours: int.tryParse(json['credit_hours']?.toString() ?? '0') ?? 0,
      semester: json['semester']?.toString() ?? 'Semester 1',
      // CRITICAL: Handle both string and int teacher_id
      teacherId: json['teacher_id'] is int
          ? json['teacher_id'] as int
          : int.tryParse(json['teacher_id']?.toString() ?? '0') ?? 0,
      description: json['description']?.toString() ?? 'No description available',
      schedule: Schedule.fromJson(json['schedule'] ?? {}),
    );
  }
}

class Schedule {
  final String day;
  final String time;

  Schedule({
    required this.day,
    required this.time,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day']?.toString() ?? 'Monday',
      time: json['time']?.toString() ?? '9:00 AM',
    );
  }
}