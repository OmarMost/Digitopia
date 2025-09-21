import 'package:flutter/material.dart';
import 'src/app_state.dart';
import 'screens/auth_screen.dart';
import 'screens/student_assessment.dart';
import 'screens/student_home.dart';
import 'screens/student_search.dart';
import 'screens/mentor_home.dart';
import 'screens/mentor_new_session.dart';
import 'screens/student_profile.dart';
import 'screens/mentor_profile.dart';
import 'screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  await appState.loadFromPrefs();
  runApp(MyApp(appState: appState));
}

class MyApp extends StatefulWidget {
  final AppState appState;
  const MyApp({Key? key, required this.appState}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final _appState = widget.appState;
    return AnimatedBuilder(
      animation: _appState,
      builder: (context, _) {
        final seed = Colors.indigo;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Students & Mentors',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seed,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seed,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: _appState.themeMode,
          initialRoute: '/',
          routes: {
            '/': (c) => AuthScreen(appState: _appState),
            '/student/assessment':
                (c) => StudentAssessment(appState: _appState),
            '/student/home': (c) => StudentHome(appState: _appState),
            '/student/search': (c) => StudentSearch(appState: _appState),
            '/student/profile': (c) => StudentProfile(appState: _appState),
            '/mentor/home': (c) => MentorHome(appState: _appState),
            '/mentor/profile': (c) => MentorProfile(appState: _appState),
            '/mentor/new_session': (c) => MentorNewSession(appState: _appState),
            '/settings': (c) => SettingsScreen(appState: _appState),
          },
        );
      },
    );
  }
}
