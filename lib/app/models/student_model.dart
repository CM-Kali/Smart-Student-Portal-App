class StudentModel {
  final String uid;
  final String name;
  final String email;
  final String rollNo;
  final String department;

  StudentModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.rollNo,
    required this.department,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'rollNo': rollNo,
      'department': department,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      rollNo: json['rollNo'],
      department: json['department'],
    );
  }
}
