class CourseModel {
  final String id;
  final String name;
  final String instructor;
  final String credits;

  CourseModel({
    required this.id,
    required this.name,
    required this.instructor,
    required this.credits,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      name: json['name'],
      instructor: json['instructor'],
      credits: json['credits'],
    );
  }
}
