class AssignmentModel {
  final String title;
  bool isSubmitted;
  String? fileName;

  AssignmentModel({
    required this.title,
    this.isSubmitted = false,
    this.fileName,
  });
}
