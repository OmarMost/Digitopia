import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class StudentProfile extends StatefulWidget {
  final AppState appState;
  const StudentProfile({Key? key, required this.appState}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(
      text: widget.appState.currentUser?.name ?? '',
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final newName = _nameCtrl.text.trim();
    if (newName.isNotEmpty) {
      widget.appState.updateUserName(newName);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
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
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
