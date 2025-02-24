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
        backgroundColor: const Color(0xFF1A1F38), // Dark background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
          side: BorderSide(
            color: Colors.purple.withOpacity(0.2), // Purple border
            width: 1,
          ),
        ),
        title: Text(
          todo == null ? 'Add Task' : 'Edit Task',
          style: const TextStyle(
            color: Colors.white, // White text
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white), // White text
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // Light hint text
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.purple.withOpacity(0.5), // Purple border
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.purple.withOpacity(0.5), // Purple border
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF9C27B0), // Purple border
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.white), // White text
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)), // Light hint text
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.purple.withOpacity(0.5), // Purple border
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.purple.withOpacity(0.5), // Purple border
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF9C27B0), // Purple border
                    ),
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
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70), // Light text
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Title cannot be empty')),
                  );
                  return;
                }

                if (todo == null) {
                  await databaseServices.addTodoItem(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    completed: false,
                    timeStamp: Timestamp.now(),
                  );
                } else {
                  await databaseServices.updateTodo(
                    todo.id,
                    titleController.text.trim(),
                    descriptionController.text.trim(),
                  );
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(todo == null ? 'Task added' : 'Task updated'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                print('Error adding/updating todo: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9C27B0), // Purple button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              todo == null ? 'Add' : 'Update',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}