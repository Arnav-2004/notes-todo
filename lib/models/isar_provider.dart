import 'package:isar/isar.dart';
import 'package:flutter_application_1/models/notes/note.dart';
import 'package:flutter_application_1/models/todos/todo.dart';
import 'package:path_provider/path_provider.dart';

class IsarProvider {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open([NoteSchema, TodoSchema], directory: dir.path);
  }
}
