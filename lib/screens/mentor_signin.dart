import 'package:flutter/material.dart';
import '../src/app_state.dart';

class MentorSignIn extends StatefulWidget {
  final AppState appState;
  const MentorSignIn({Key? key, required this.appState}) : super(key: key);

  @override
  State<MentorSignIn> createState() => _MentorSignInState();
}

class _MentorSignInState extends State<MentorSignIn> {
  final TextEditingController _subjectsCtrl = TextEditingController();
  final TextEditingController _yearsCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mentor = widget.appState.mentors.firstWhere(
      (m) => m.name == widget.appState.currentUser?.name,
      orElse: () => widget.appState.mentors.first,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => widget.appState.toggleThemeMode(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Hello, ${mentor.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
              controller: _subjectsCtrl,
              decoration: const InputDecoration(
                labelText: 'Subjects (comma-separated)',
              ),
            ),
            TextField(
              controller: _yearsCtrl,
              decoration: const InputDecoration(labelText: 'Years experience'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final sub =
                    _subjectsCtrl.text
                        .split(',')
                        .map((s) => s.trim())
                        .where((s) => s.isNotEmpty)
                        .toList();
                final years = int.tryParse(_yearsCtrl.text) ?? 0;
                widget.appState.addMentorDetails(mentor.id, sub, years);
                Navigator.pushReplacementNamed(context, '/mentor/home');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
