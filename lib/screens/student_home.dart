import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../src/models.dart';
import '../widgets/app_drawer.dart';

class StudentHome extends StatelessWidget {
  final AppState appState;
  const StudentHome({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final career =
        ModalRoute.of(context)!.settings.arguments as String? ??
        'Recommended career';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Home'),
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
              'Hello, ${appState.currentUser?.name ?? 'Student'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Career recommendation: $career',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text('Upcoming sessions:', style: TextStyle(fontSize: 16)),
            Expanded(
              child: ListView.builder(
                itemCount: appState.sessions.length,
                itemBuilder: (context, idx) {
                  final s = appState.sessions[idx];
                  final mentor = appState.mentors.firstWhere(
                    (m) => m.id == s.mentorId,
                    orElse: () => Mentor(id: 'unknown', name: 'Unknown'),
                  );
                  return ListTile(
                    title: Text(s.title),
                    subtitle: Text('with ${mentor.name} - ${s.time.toLocal()}'),
                    trailing:
                        s.studentId == null
                            ? ElevatedButton(
                              onPressed: () {
                                appState.bookSession(
                                  s.id,
                                  appState.currentUser!.id,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Booked')),
                                );
                              },
                              child: const Text('Book'),
                            )
                            : const Text('Booked'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/student/search'),
              child: const Text('Search Mentors'),
            ),
          ],
        ),
      ),
    );
  }
}
