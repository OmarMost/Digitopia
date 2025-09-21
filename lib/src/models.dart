class User {
  final String id;
  final String name;
  final bool isMentor;

  User({required this.id, required this.name, this.isMentor = false});
}

class Mentor {
  final String id;
  final String name;
  final List<String> subjects;
  final int yearsExperience;

  Mentor({
    required this.id,
    required this.name,
    this.subjects = const [],
    this.yearsExperience = 0,
  });
}

class Session {
  final String id;
  final String title;
  final String mentorId;
  final DateTime time;
  final String? studentId;

  Session({
    required this.id,
    required this.title,
    required this.mentorId,
    required this.time,
    this.studentId,
  });
}
