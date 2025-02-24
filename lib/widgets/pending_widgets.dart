import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/firebase/services/database_services.dart';
import 'package:todoapp/widgets/taskDialog.dart';

class PendingWidgets extends StatefulWidget {
  const PendingWidgets({super.key});

  @override
  State createState() => _PendingWidgetsState();
}

class _PendingWidgetsState extends State {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;
  final DatabaseServices databaseServices = DatabaseServices();
  
  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseServices.pendingTodos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9C27B0)),
            ),
          );
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 70,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  "No pending tasks",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add a new task to get started",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
        
        List todos = snapshot.data!;
        return SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: ListView.builder(
            itemCount: todos.length,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              final DateTime dt = todo.timeStamp.toDate();
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Slidable(
                  key: ValueKey(todo.id),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: const Color(0xFF673AB7),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: "Edit",
                        onPressed: (context) {
                          showTaskDialog(context, todo: todo);
                        },
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                        ),
                      ),
                      SlidableAction(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) {
                          databaseServices.deleteTodo(todo.id);
                        },
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: const Color(0xFF9C27B0),
                        foregroundColor: Colors.white,
                        icon: Icons.done,
                        label: "Complete",
                        onPressed: (context) {
                          databaseServices.updateTodoStatus(todo.id, true);
                        },
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(16),
                        ),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1F38),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.purple.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  todo.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF9C27B0).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${dt.day}/${dt.month}/${dt.year}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (todo.description.isNotEmpty) ... [
                            const SizedBox(height: 8),
                            Text(
                              todo.description,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Pending",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}