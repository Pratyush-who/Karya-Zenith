import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebase/services/database_services.dart';

void showTaskDialog(BuildContext context, {Todo? todo}) {
  final TextEditingController titleController = TextEditingController(
    text: todo?.title,
  );
  final TextEditingController descriptionController = TextEditingController(
    text: todo?.description,
  );
  final DatabaseServices databaseServices = DatabaseServices();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          todo == null ? 'Add Task' : 'Edit Task',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
  onPressed: () async {
    try {
      // Add some basic validation
      if (titleController.text.trim().isEmpty) {
        return;
      }

      // For new todo
      if (todo == null) {
        await databaseServices.addTodoItem(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          completed: false,
          timeStamp: Timestamp.now(),
        );
        print('Todo added successfully'); // Add this for debugging
      } else {
        await databaseServices.updateTodo(
          todo.id,
          titleController.text.trim(),
          descriptionController.text.trim(),
        );
      }
      Navigator.pop(context);
    } catch (e) {
      print('Error adding/updating todo: $e'); // Add this for debugging
    }
  },
  child: Text(todo == null ? 'Add' : 'Update'),
),
        ],
      );
    },
  );
}
