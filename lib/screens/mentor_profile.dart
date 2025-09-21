import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class MentorProfile extends StatefulWidget {
  final AppState appState;
  const MentorProfile({Key? key, required this.appState}) : super(key: key);

  @override
  State<MentorProfile> createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile> {
  late TextEditingController _subjectsCtrl;
  late TextEditingController _yearsCtrl;

  @override
  void initState() {
    super.initState();
    final mentor = widget.appState.mentors.firstWhere(
      (m) => m.name == widget.appState.currentUser?.name,
      orElse: () => widget.appState.mentors.first,
    );
    _subjectsCtrl = TextEditingController(text: mentor.subjects.join(', '));
    _yearsCtrl = TextEditingController(text: mentor.yearsExperience.toString());
  }

  @override
  void dispose() {
    _subjectsCtrl.dispose();
    _yearsCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final subjects =
        _subjectsCtrl.text
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
    final years = int.tryParse(_yearsCtrl.text) ?? 0;
    final mentor = widget.appState.mentors.firstWhere(
      (m) => m.name == widget.appState.currentUser?.name,
      orElse: () => widget.appState.mentors.first,
    );
    widget.appState.updateMentorProfile(mentor.id, subjects, years);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Mentor profile saved')));
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: AppDrawer(appState: widget.appState),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _subjectsCtrl,
              decoration: const InputDecoration(
                labelText: 'Subjects (comma-separated)',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _yearsCtrl,
              decoration: const InputDecoration(labelText: 'Years experience'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
