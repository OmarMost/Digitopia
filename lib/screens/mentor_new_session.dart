import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class MentorNewSession extends StatefulWidget {
  final AppState appState;
  const MentorNewSession({Key? key, required this.appState}) : super(key: key);

  @override
  State<MentorNewSession> createState() => _MentorNewSessionState();
}

class _MentorNewSessionState extends State<MentorNewSession> {
  final TextEditingController _titleCtrl = TextEditingController();
  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    final mentor = widget.appState.mentors.firstWhere(
      (m) => m.name == widget.appState.currentUser?.name,
      orElse: () => widget.appState.mentors.first,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Session'),
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
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Session title'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final dt = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (dt != null) {
                      final t = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (t != null) {
                        setState(
                          () =>
                              _time = DateTime(
                                dt.year,
                                dt.month,
                                dt.day,
                                t.hour,
                                t.minute,
                              ),
                        );
                      }
                    }
                  },
                  child: const Text('Pick date & time'),
                ),
                const SizedBox(width: 8),
                Text(_time == null ? 'No time' : _time!.toLocal().toString()),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_titleCtrl.text.isNotEmpty && _time != null) {
                  widget.appState.createSession(
                    _titleCtrl.text.trim(),
                    mentor.id,
                    _time!,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
