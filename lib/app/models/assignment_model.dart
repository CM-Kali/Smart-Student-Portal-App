class AssignmentModel {
  final String id;
  final String title;
  final String subject;
  final String dueDate;
  final String description;
  final int marks;
  bool isSubmitted;
  String? fileName;
  String? submittedDate;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.description,
    required this.marks,
    this.isSubmitted = false,
    this.fileName,
    this.submittedDate,
  });

  bool get isOverdue {
    try {
      final parts = dueDate.split(' ');
      final day = int.parse(parts[0]);
      final month = _getMonthNumber(parts[1]);
      final dueDateTime = DateTime(DateTime.now().year, month, day);
      return DateTime.now().isAfter(dueDateTime) && !isSubmitted;
    } catch (e) {
      return false;
    }
  }

  int _getMonthNumber(String month) {
    const months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
      'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };
    return months[month] ?? 1;
  }
}