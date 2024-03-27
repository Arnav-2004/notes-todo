import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drawer_tile.dart';
import 'package:flutter_application_1/pages/notes_page.dart';
import 'package:flutter_application_1/pages/settings_page.dart';
import 'package:flutter_application_1/pages/todo_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.add_home_work)),
          // Notes Tile
          DrawerTile(
            title: "Notes",
            leading: const Icon(Icons.note),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotesPage(),
              ),
            ),
          ),

          // To-Do Tile
          DrawerTile(
            title: "Todo",
            leading: const Icon(Icons.task),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoPage(),
              ),
            ),
          ),

          // Settings Tile
          DrawerTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            ),
          ),
        ],
      )
    );
  }
}
