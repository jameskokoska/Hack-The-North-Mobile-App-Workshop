import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:template/main.dart';
import 'package:template/widgets/popup_framework.dart';
import 'package:template/struct/todo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    //Run this immediately after the UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      todoController.emitStream();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTodoBottomSheet(context),
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: todoController.todosStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No todos available"));
          }

          final todos = snapshot.data!;

          return ImplicitlyAnimatedList(
            itemData: todos,
            itemBuilder: (context, todo) {
              // TODO: Implement the task component
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  addTodo(String todoName) {
    final taskName = todoName.trim();
    if (taskName.isNotEmpty) {
      todoController.addTodo(taskName);
    }
  }

  void _showAddTodoBottomSheet(BuildContext context) {
    final TextEditingController taskController = TextEditingController();

    openBottomSheet(
      context,
      PopupFramework(
        title: "Add New Todo",
        children: [
          TextField(
            autofocus: true,
            controller: taskController,
            decoration: const InputDecoration(labelText: 'Task Name'),
            onSubmitted: (value) {
              addTodo(value);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showEditTodoBottomSheet(BuildContext context, Todo todo) {
    final TextEditingController taskController =
        TextEditingController(text: todo.taskName);

    openBottomSheet(
      context,
      PopupFramework(
        title: "Edit Todo",
        children: [
          TextField(
            autofocus: true,
            controller: taskController,
            decoration: const InputDecoration(labelText: 'Task Name'),
            onSubmitted: (value) {
              final taskName = taskController.text.trim();
              if (taskName.isNotEmpty) {
                todoController.updateTodo(todo.copyWith(taskName: taskName));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
