class AssignmentModel {
  final String title;
  final String dueDate;
  bool isSubmitted;
  String? fileName;

  AssignmentModel({
    required this.title,
    required this.dueDate,
    this.isSubmitted = false,
    this.fileName,
  });
}
