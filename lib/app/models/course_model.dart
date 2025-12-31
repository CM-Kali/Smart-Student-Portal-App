class CourseModel {
  final String id;
  final String title;
  final String code;
  final int creditHours;
  final String semester;
  final String description;
  final String day;
  final String time;

  CourseModel({
    required this.id,
    required this.title,
    required this.code,
    required this.creditHours,
    required this.semester,
    required this.description,
    required this.day,
    required this.time,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      code: json['code'] ?? '',
      creditHours: json['credit_hours'] ?? 0,
      semester: json['semester'] ?? '',
      description: json['description'] ?? '',
      day: json['schedule']?['day'] ?? '',
      time: json['schedule']?['time'] ?? '',
    );
  }
}
