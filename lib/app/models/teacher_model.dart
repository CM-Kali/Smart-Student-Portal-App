class TeacherModel {
  final String id;
  final String name;
  final String subject;
  final String email;
  final String photo; // Add this
  final String introduction; // Add this

  TeacherModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.email,
    required this.photo,
    required this.introduction,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      email: json['email'],
      photo: json['photo'] ?? 'assets/images/default_teacher.png', // Default photo
      introduction: json['introduction'] ?? 'No introduction available',
    );
  }
}