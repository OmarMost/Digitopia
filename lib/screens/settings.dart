import 'package:flutter/material.dart';
import '../src/app_state.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  final AppState appState;
  const SettingsScreen({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => appState.toggleThemeMode(),
          ),
        ],
      ),
      drawer: AppDrawer(appState: appState),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Settings (placeholder)'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No settings yet')),
                  ),
              child: const Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
