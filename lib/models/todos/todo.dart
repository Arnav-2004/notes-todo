import 'package:isar/isar.dart';

// run: dart run build_runner build
part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  late String text;
  bool completed = false;
}
