import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drawer.dart';
import 'package:flutter_application_1/components/todo_tile.dart';
import 'package:flutter_application_1/models/todos/todo.dart';
import 'package:flutter_application_1/models/todos/todo_database.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // Text controller
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Fetch existing todos on App startup
    readTodos();
  }

  void createTodo() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text("Create Todo"),
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Task Desc",
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // Add todo to database
                    context
                        .read<TodoDatabase>()
                        .createTodo(textController.text);

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

  void readTodos() {
    context.read<TodoDatabase>().readTodos();
  }

  void updateTodo(Todo todo) {
    // Fill the text controller with todo text
    textController.text = todo.text;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text("Update Todo"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // Update todo in database
                    context
                        .read<TodoDatabase>()
                        .updateTodo(todo.id, textController.text);

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

  void deleteTodo(int id) {
    context.read<TodoDatabase>().deleteTodo(id);
  }

  void completeTodo(int id) {
    context.read<TodoDatabase>().completeTodo(id);
  }

  @override
  Widget build(BuildContext context) {
    // Todos database
    final todoDatabase = context.watch<TodoDatabase>();

    // Current todos
    List<Todo> currTodos = todoDatabase.currTodos;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createTodo,
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
              "To Do",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          // List of todos
          Expanded(
            child: ListView.builder(
                itemCount: currTodos.length,
                itemBuilder: (context, index) {
                  // Get individual todo
                  final todo = currTodos[index];

                  // List Tile UI
                  return TodoTile(
                    text: todo.text,
                    completed: todo.completed,
                    onEditPressed: () => updateTodo(todo),
                    onDeletePressed: () => deleteTodo(todo.id),
                    onCompletePressed: () => completeTodo(todo.id),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
