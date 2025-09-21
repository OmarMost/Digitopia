import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class MentorHome extends StatelessWidget {
  final AppState appState;
  const MentorHome({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mentor = appState.mentors.firstWhere(
      (m) => m.name == appState.currentUser?.name,
      orElse: () => appState.mentors.first,
    );
    final mySessions =
        appState.sessions.where((s) => s.mentorId == mentor.id).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => appState.toggleThemeMode(),
          ),
        ],
      ),
      drawer: AppDrawer(appState: appState),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome, ${mentor.name}',
              style: const TextStyle(fontSize: 20),
            ),
            Text('Subjects: ${mentor.subjects.join(', ')}'),
            Text('Experience: ${mentor.yearsExperience} years'),
            const SizedBox(height: 12),
            const Text('Your upcoming sessions:'),
            Expanded(
              child: ListView.builder(
                itemCount: mySessions.length,
                itemBuilder: (context, idx) {
                  final s = mySessions[idx];
                  return ListTile(
                    title: Text(s.title),
                    subtitle: Text(s.time.toLocal().toString()),
                    trailing:
                        s.studentId == null
                            ? const Text('Open')
                            : Text('Booked by ${s.studentId}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed:
                  () => Navigator.pushNamed(context, '/mentor/new_session'),
              child: const Text('Create Session'),
            ),
          ],
        ),
      ),
    );
  }
}
