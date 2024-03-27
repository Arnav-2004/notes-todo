import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/isar_provider.dart';
import 'package:flutter_application_1/models/notes/note_database.dart';
import 'package:flutter_application_1/models/todos/todo_database.dart';
import 'package:flutter_application_1/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/notes_page.dart';

void main() async {
  // Initialize the isar database
  WidgetsFlutterBinding.ensureInitialized();
  await IsarProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteDatabase()),
        ChangeNotifierProvider(create: (context) => TodoDatabase()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

      ],
      child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
