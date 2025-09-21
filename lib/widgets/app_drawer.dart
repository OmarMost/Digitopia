import 'package:flutter/material.dart';
import '../src/app_state.dart';

class AppDrawer extends StatelessWidget {
  final AppState appState;
  const AppDrawer({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = appState.currentUser?.name ?? 'Guest';
    final role = appState.currentUser?.isMentor == true ? 'Mentor' : 'Student';
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(role),
              currentAccountPicture: CircleAvatar(
                child: Text(name.isNotEmpty ? name[0] : '?'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                if (appState.currentUser?.isMentor == true)
                  Navigator.pushNamed(context, '/mentor/profile');
                else
                  Navigator.pushNamed(context, '/student/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Upcoming Sessions'),
              onTap: () {
                Navigator.pop(context);
                if (appState.currentUser?.isMentor == true)
                  Navigator.pushNamed(context, '/mentor/home');
                else
                  Navigator.pushNamed(context, '/student/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () {
                Navigator.pop(context);
                appState.logout().then((_) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, '/');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
