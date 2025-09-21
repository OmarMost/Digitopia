import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class StudentAssessment extends StatefulWidget {
  final AppState appState;
  const StudentAssessment({Key? key, required this.appState}) : super(key: key);

  @override
  State<StudentAssessment> createState() => _StudentAssessmentState();
}

class _StudentAssessmentState extends State<StudentAssessment> {
  int _score = 0;

  void _answer(int value) {
    setState(() => _score += value);
  }

  void _finish() {
    String career;
    if (_score < 3)
      career = 'Designer';
    else if (_score < 6)
      career = 'Developer';
    else
      career = 'Data Scientist';

    Navigator.pushReplacementNamed(context, '/student/home', arguments: career);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Assessment'),
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
            const Text('Question 1: Do you enjoy building interfaces?'),
            Row(
              children: [
                TextButton(
                  onPressed: () => _answer(0),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => _answer(1),
                  child: const Text('Yes'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Question 2: Do you like algorithms & problem solving?'),
            Row(
              children: [
                TextButton(
                  onPressed: () => _answer(0),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => _answer(1),
                  child: const Text('Yes'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Question 3: Do you enjoy working with data?'),
            Row(
              children: [
                TextButton(
                  onPressed: () => _answer(0),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => _answer(2),
                  child: const Text('Yes, a lot'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _finish,
              child: const Text('See recommendation'),
            ),
          ],
        ),
      ),
    );
  }
}
