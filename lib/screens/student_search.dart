import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class StudentSearch extends StatefulWidget {
  final AppState appState;
  const StudentSearch({Key? key, required this.appState}) : super(key: key);

  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final results =
        widget.appState.mentors
            .where(
              (m) =>
                  m.name.toLowerCase().contains(_query.toLowerCase()) ||
                  m.subjects.any(
                    (s) => s.toLowerCase().contains(_query.toLowerCase()),
                  ),
            )
            .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Mentors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => widget.appState.toggleThemeMode(),
          ),
        ],
      ),
      drawer: AppDrawer(appState: widget.appState),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name or subject',
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, idx) {
                  final m = results[idx];
                  return ListTile(
                    title: Text(m.name),
                    subtitle: Text('Subjects: ${m.subjects.join(', ')}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // go to mentor profile or book a session
                        Navigator.pushNamed(context, '/mentor/home');
                      },
                      child: const Text('View'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
