import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/isar_provider.dart';
import 'package:flutter_application_1/models/notes/note.dart';
import 'package:isar/isar.dart';

class NoteDatabase extends ChangeNotifier {
  static Isar get isar => IsarProvider.isar;

  // List of notes
  final List<Note> currNotes = [];

  // Create
  Future<void> createNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;
    await isar.writeTxn(() => isar.notes.put(newNote));
    await readNotes();
  }

  // Read
  Future<void> readNotes() async {
    List<Note> fetchedNote = await isar.notes.where().findAll();
    currNotes.clear();
    currNotes.addAll(fetchedNote);
    notifyListeners();
  }

  // Update
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await readNotes();
    }
  }

  // Delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await readNotes();
  }
}
