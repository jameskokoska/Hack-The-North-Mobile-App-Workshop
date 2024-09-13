import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:template/controllers/todo_controller.dart';
import 'package:template/widgets/popup_framework.dart';
import 'package:template/struct/todo.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
      body: Builder(builder: (context) {
        TodoController todoController = Provider.of<TodoController>(context);
        return todoController.todos.isEmpty
            ? const Center(child: Text("No todos available"))
            : ImplicitlyAnimatedList(
                itemData: todoController.todos,
                itemBuilder: (context, todo) {
                  // TODO: Implement the task component
                  return const SizedBox.shrink();
                },
              );
      }),
    );
  }

  addTodo(String todoName) {
    final taskName = todoName.trim();
    if (taskName.isNotEmpty) {
      TodoController todoControllerInstance =
          Provider.of<TodoController>(context, listen: false);
      todoControllerInstance.addTodo(taskName);
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
                TodoController todoControllerInstance =
                    Provider.of<TodoController>(context, listen: false);
                todoControllerInstance
                    .updateTodo(todo.copyWith(taskName: taskName));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
