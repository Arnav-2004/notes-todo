import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drawer.dart';
import 'package:flutter_application_1/components/note_tile.dart';
import 'package:flutter_application_1/models/notes/note.dart';
import 'package:flutter_application_1/models/notes/note_database.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Text controller
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Fetch existing notes on App startup
    readNotes();
  }

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text("Create Note"),
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // Add note to database
                    context
                        .read<NoteDatabase>()
                        .createNote(textController.text);

                    // Clear text controller
                    textController.clear();

                    // Pop the dialog box
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                )
              ],
            ));
  }

  void readNotes() {
    context.read<NoteDatabase>().readNotes();
  }

  void updateNote(Note note) {
    // Fill the text controller with note text
    textController.text = note.text;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text("Update Note"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // Update note in database
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);

                    // Clear text controller
                    textController.clear();

                    // Pop the dialog box
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                )
              ],
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // Note database
    final noteDatabase = context.watch<NoteDatabase>();

    // Current notes
    List<Note> currNotes = noteDatabase.currNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // List of notes
          Expanded(
            child: ListView.builder(
                itemCount: currNotes.length,
                itemBuilder: (context, index) {
                  // Get individual note
                  final note = currNotes[index];

                  // List Tile UI
                  return NoteTile(
                    text: note.text,
                    onEditPressed: () => updateNote(note),
                    onDeletePressed: () => deleteNote(note.id),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
