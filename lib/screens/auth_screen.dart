import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class AuthScreen extends StatefulWidget {
  final AppState appState;
  const AuthScreen({Key? key, required this.appState}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
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
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Your name'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final name = _nameCtrl.text.trim();
                      if (name.isNotEmpty) {
                        widget.appState.signInAsStudent(name);
                        Navigator.pushReplacementNamed(
                          context,
                          '/student/assessment',
                        );
                      }
                    },
                    child: const Text('Sign in as Student'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      final name = _nameCtrl.text.trim();
                      if (name.isNotEmpty) {
                        widget.appState.signInAsMentor(name);
                        Navigator.pushReplacementNamed(context, '/mentor/home');
                      }
                    },
                    child: const Text('Sign in as Mentor'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
