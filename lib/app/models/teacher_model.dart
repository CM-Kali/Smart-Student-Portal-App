class TeacherModel {
  final String id;
  final String name;
  final String subject;
  final String email;

  TeacherModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.email,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      email: json['email'],
    );
  }
}
