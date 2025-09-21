import 'package:flutter/material.dart';
import 'models.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  User? currentUser;
  final List<Mentor> mentors = [];
  final List<Session> sessions = [];
  ThemeMode themeMode = ThemeMode.system;

  void toggleThemeMode() {
    if (themeMode == ThemeMode.light)
      themeMode = ThemeMode.dark;
    else if (themeMode == ThemeMode.dark)
      themeMode = ThemeMode.light;
    else
      themeMode = ThemeMode.light;
    _saveThemeToPrefs();
    notifyListeners();
  }

  // Persistence
  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode');
    if (themeIndex != null) {
      themeMode =
          ThemeMode.values[themeIndex.clamp(0, ThemeMode.values.length - 1)];
    }

    final userId = prefs.getString('user_id');
    final userName = prefs.getString('user_name');
    final userIsMentor = prefs.getBool('user_isMentor');
    if (userId != null && userName != null && userIsMentor != null) {
      currentUser = User(id: userId, name: userName, isMentor: userIsMentor);
    }
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }

  Future<void> _saveUserToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (currentUser == null) {
      await prefs.remove('user_id');
      await prefs.remove('user_name');
      await prefs.remove('user_isMentor');
    } else {
      await prefs.setString('user_id', currentUser!.id);
      await prefs.setString('user_name', currentUser!.name);
      await prefs.setBool('user_isMentor', currentUser!.isMentor);
    }
  }

  AppState() {
    // seed demo mentors
    mentors.addAll([
      Mentor(
        id: 'm1',
        name: 'Alice Johnson',
        subjects: ['Flutter', 'Dart'],
        yearsExperience: 4,
      ),
      Mentor(
        id: 'm2',
        name: 'Bob Smith',
        subjects: ['Data Science', 'Python'],
        yearsExperience: 6,
      ),
    ]);

    // seed demo sessions
    sessions.addAll([
      Session(
        id: 's1',
        title: 'Intro to Flutter',
        mentorId: 'm1',
        time: DateTime.now().add(Duration(days: 2)),
      ),
      Session(
        id: 's2',
        title: 'Data Science Q&A',
        mentorId: 'm2',
        time: DateTime.now().add(Duration(days: 3)),
      ),
    ]);
  }

  void signInAsStudent(String name) {
    currentUser = User(
      id: 'u${Random().nextInt(10000)}',
      name: name,
      isMentor: false,
    );
    _saveUserToPrefs();
    notifyListeners();
  }

  void signInAsMentor(String name) {
    currentUser = User(
      id: 'u${Random().nextInt(10000)}',
      name: name,
      isMentor: true,
    );
    // if mentor not in list, add
    if (!mentors.any((m) => m.name == name)) {
      mentors.add(Mentor(id: 'm${mentors.length + 1}', name: name));
    }
    _saveUserToPrefs();
    notifyListeners();
  }

  void addMentorDetails(String id, List<String> subjects, int years) {
    final idx = mentors.indexWhere((m) => m.id == id);
    if (idx != -1) {
      mentors[idx] = Mentor(
        id: mentors[idx].id,
        name: mentors[idx].name,
        subjects: subjects,
        yearsExperience: years,
      );
    }
    notifyListeners();
  }

  void bookSession(String sessionId, String studentId) {
    final idx = sessions.indexWhere((s) => s.id == sessionId);
    if (idx != -1) {
      sessions[idx] = Session(
        id: sessions[idx].id,
        title: sessions[idx].title,
        mentorId: sessions[idx].mentorId,
        time: sessions[idx].time,
        studentId: studentId,
      );
      notifyListeners();
    }
  }

  void createSession(String title, String mentorId, DateTime time) {
    sessions.add(
      Session(
        id: 's${sessions.length + 1}',
        title: title,
        mentorId: mentorId,
        time: time,
      ),
    );
    notifyListeners();
  }

  // Profile update helpers
  void updateUserName(String newName) {
    if (currentUser == null) return;
    currentUser = User(
      id: currentUser!.id,
      name: newName,
      isMentor: currentUser!.isMentor,
    );
    _saveUserToPrefs();
    notifyListeners();
  }

  void updateMentorProfile(String mentorId, List<String> subjects, int years) {
    final idx = mentors.indexWhere((m) => m.id == mentorId);
    if (idx != -1) {
      mentors[idx] = Mentor(
        id: mentors[idx].id,
        name: mentors[idx].name,
        subjects: subjects,
        yearsExperience: years,
      );
      notifyListeners();
    }
  }

  // Logout and clear persisted user
  Future<void> logout() async {
    currentUser = null;
    await _saveUserToPrefs();
    notifyListeners();
  }
}
